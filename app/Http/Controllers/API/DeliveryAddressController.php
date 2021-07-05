<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\DeliveryAddress;
use App\Models\Vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DeliveryAddressController extends Controller
{

    public function index(Request $request)
    {

        $vendor = Vendor::find($request->vendor_id);

        if ($request->action == "default") {
            //default delivery address
            $deliveryAddress = DeliveryAddress::where('user_id', "=", Auth::id())->where('is_default', 1)
                ->when($request->vendor_id, function ($query) use ($vendor) {
                    return $query->distance($vendor->latitude, $vendor->longitude);
                })->first();

            // if (empty($deliveryAddress)) {
            //     $deliveryAddress = DeliveryAddress::where('user_id', "=", Auth::id())
            //         ->when($request->vendor_id, function ($query) use ($vendor) {
            //             return $query->distance($vendor->latitude, $vendor->longitude);
            //         })->first();
            // }

            return $deliveryAddress;
        } else {

            $deliveryAddresses = DeliveryAddress::where('user_id', "=", Auth::id())
                ->when($request->vendor_id, function ($query) use ($vendor) {
                    return $query->distance($vendor->latitude, $vendor->longitude);
                })->orderBy('updated_at','DESC')->get();
            return response()->json([
                "data" => $deliveryAddresses,
                "vendor" => $vendor,
            ], 200);
        }
    }

    public function store(Request $request)
    {

        try {

            $model = new DeliveryAddress();
            $model->fill($request->all());
            $model->user_id = Auth::id();
            $model->save();

            return response()->json([
                "message" => "Delivery address created successfully"
            ], 200);
        } catch (\Exception $ex) {

            return response()->json([
                "message" => $ex->getMessage() ?? "Delivery address creation failed"
            ], 400);
        }
    }

    public function update(Request $request, $id)
    {

        try {

            $model = DeliveryAddress::where('user_id', Auth::id())->where('id', $id)->firstorfail();
            $model->fill($request->all());
            $model->save();

            return response()->json([
                "message" => "Delivery address updated successfully"
            ], 200);
        } catch (\Exception $ex) {

            return response()->json([
                "message" => "Delivery address update failed"
            ], 400);
        }
    }

    public function destroy(Request $request, $id)
    {

        try {

            DeliveryAddress::where('user_id', Auth::id())->where('id', $id)->firstorfail()->delete();
            return response()->json([
                "message" => "Delivery address deleted successfully"
            ], 200);
        } catch (\Exception $ex) {
            logger("Erro", [$ex]);
            return response()->json([
                "message" => "No Delivery address Found"
            ], 400);
        }
    }
}
