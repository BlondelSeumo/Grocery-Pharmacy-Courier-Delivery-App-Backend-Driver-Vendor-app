<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\City;
use App\Models\State;
use App\Models\Country;
use App\Models\CityVendor;
use App\Models\StateVendor;
use App\Models\CountryVendor;
use App\Models\DeliveryAddress;
use App\Models\PackageTypePricing;
use App\Models\Vendor;
use Illuminate\Http\Request;


class PackageOrderController extends Controller
{

    //
    public function summary(Request $request)
    {

        // logger("Summary", [$request->all()]);
        //check if delivery addresses are with vendor cities
        if (!$this->isCityAllowedInSystem($request->pickup_location_id)) {
            return response()->json([
                "message" => "System does not service pickup location",
            ], 400);
        }
        //check iof city is even in the system
        else if (!$this->isCityAllowedInSystem($request->dropoff_location_id)) {
            return response()->json([
                "message" => "System does not service dropoff location",
            ], 400);
        }


        //check if vendor service the city
        if (!$this->isCityAllowedByVendor($request->vendor_id, $request->pickup_location_id)) {
            return response()->json([
                "message" => "Vendor does not service pickup location",
            ], 400);
        } else if (!$this->isCityAllowedByVendor($request->vendor_id, $request->dropoff_location_id)) {
            return response()->json([
                "message" => "Vendor does not service dropoff location",
            ], 400);
        }

        //
        $deliveryLocationDistance = 0;


        //for stops
        if (!empty($request->stops)) {

            $stops = $request->stops;
            $totalStops = count($stops);
            $newTotalStops = $totalStops - 1;
            //
            for ($i = 0; $i < $newTotalStops; $i++) {
                //
                $stop = $stops[$i];
                $nextStop = $stops[$i + 1];

                //check iof city is even in the system
                if (!$this->isCityAllowedInSystem($stop["id"])) {
                    return response()->json([
                        "message" => "System does not service stop location",
                    ], 400);
                }


                //check if vendor service the city
                if (!$this->isCityAllowedByVendor($request->vendor_id, $stop["id"])) {
                    return response()->json([
                        "message" => "Vendor does not service stop location",
                    ], 400);
                }


                //sum up the stop distance
                $deliveryLocationDistance += $this->getDistanceBetweenStop($stop["id"], $nextStop["id"]);
            }
        } else {

            //dropoff location distance calculation
            $dropoffLocation = $this->getDeliveryAddress($request->dropoff_location_id);
            $deliveryLocationDistance = DeliveryAddress::distance($dropoffLocation->latitude, $dropoffLocation->longitude)
                ->where('id', $request->pickup_location_id)
                ->first()
                ->distance;
        }


        //
        $packageTypePricing = PackageTypePricing::where('vendor_id', $request->vendor_id)
            ->where('package_type_id', $request->package_type_id)->first();


        //calculation time
        $tax = Vendor::find($request->vendor_id)->tax;;
        $sizeAmount = 0;
        $distanceAmount = 0;
        $totalAmount = 0;

        //calculate the weigth price
        if ($packageTypePricing->price_per_kg) {
            $sizeAmount = $packageTypePricing->size_price * $request->weight;
        } else {
            $sizeAmount = $packageTypePricing->size_price;
        }


        //calculate the distance price
        if ($packageTypePricing->price_per_km) {
            $distanceAmount = $packageTypePricing->distance_price * $deliveryLocationDistance;
        } else {
            $distanceAmount = $packageTypePricing->distance_price;
        }
        $distanceAmount += $packageTypePricing->base_price;

        //total amount
        $totalAmount = $tax + $distanceAmount + $sizeAmount;

        return response()->json([
            "delivery_fee" => $distanceAmount,
            "package_type_fee" => $sizeAmount,
            "distance" => $deliveryLocationDistance,
            "sub_total" => $totalAmount - $tax,
            "tax" => (float)$tax,
            "total" => $totalAmount,
        ]);
    }



    //
    public function getDeliveryAddress($id)
    {
        return DeliveryAddress::find($id);
    }


    public function isCityAllowedInSystem($id)
    {
        $deliveryAddress = DeliveryAddress::find($id);

        //check iof city is even in the system
        $deliveryAddressCity = City::where('name', $deliveryAddress->city)->first();
        if (!empty($deliveryAddressCity)) {
            return true;
        }

        //now check if delivery state is in the system
        $deliveryAddressState = State::where('name', $deliveryAddress->state)->first();
        if (!empty($deliveryAddressState)) {
            return true;
        }


        //now check if delivery country is in the system
        $deliveryAddressCountry = Country::where('name', $deliveryAddress->country)->first();
        if (!empty($deliveryAddressCountry)) {
            return true;
        }


        return false;
    }
    public function isCityAllowedByVendor($vendorId, $id)
    {
        $deliveryAddress = DeliveryAddress::find($id);

        //check iof city is even in the system
        $deliveryAddressCity = City::where('name', $deliveryAddress->city)->first();

        if (!empty($deliveryAddressCity)) {
            $pickupLocationCityVendor = CityVendor::where('vendor_id', $vendorId)
                ->where('city_id', $deliveryAddressCity->id)
                ->first();

            if (!empty($pickupLocationCityVendor)) {
                return true;
            }
        }


        //now check if delivery state is in the system
        $deliveryAddressState = State::where('name', $deliveryAddress->state)->first();
        if (!empty($deliveryAddressState)) {
            $pickupLocationStateVendor = StateVendor::where('vendor_id', $vendorId)
                ->where('state_id', $deliveryAddressState->id)
                ->first();
            if (!empty($pickupLocationStateVendor)) {
                return true;
            }
        }

        //now check if delivery country is in the system
        $deliveryAddressCountry = Country::where('name', $deliveryAddress->country)->first();
        if (!empty($deliveryAddressCountry)) {
            $pickupLocationCountryVendor = CountryVendor::where('vendor_id', $vendorId)
                ->where('country_id', $deliveryAddressCountry->id)
                ->first();
            if (!empty($pickupLocationCountryVendor)) {
                return true;
            }
        }

        return false;
    }

    public function getDistanceBetweenStop($stopId, $nextStopId)
    {
        //dropoff location distance calculation
        $nextLocation = $this->getDeliveryAddress($nextStopId);
        return DeliveryAddress::distance($nextLocation->latitude, $nextLocation->longitude)
            ->where('id', $stopId)
            ->first()
            ->distance;
    }
}
