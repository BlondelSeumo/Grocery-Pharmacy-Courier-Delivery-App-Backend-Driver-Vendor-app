<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Vendor;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\Order;


class VendorController extends Controller
{


    public function index(Request $request)
    {

        //
        $latitude = $request->latitude;
        $longitude = $request->longitude;

        $vendors = Vendor::active()->when($request->type == "top", function ($query) {
            return $query->withCount('sales')->orderBy('sales_count', 'DESC');
        })
            ->when($request->type == "you", function ($query) {
                return $query->inRandomOrder();
            })
            ->when($request->type == "package", function ($query) {
                return $query->isPackageDelivery();
            }, function ($query) {
                return $query->regularVendor();
            })
            ->when($request->package_type_id, function ($query) use ($request) {
                return $query->with(
                    [
                        'cities' => function ($query) {
                            $query->where('is_active', 1);
                        },
                        'states'  => function ($query) {
                            $query->where('is_active', 1);
                        },
                        'countries'  => function ($query) {
                            $query->where('is_active', 1);
                        },
                    ]
                )
                    ->withAndWhereHas('package_types_pricing', function ($query) use ($request) {
                        $query->where('package_type_id', $request->package_type_id);
                    });
            })
            ->when($latitude, function ($query) use ($latitude, $longitude) {
                return $query->distance($latitude, $longitude)
                    ->havingRaw("delivery_range >= distance");
            })
            ->paginate($this->perPage);
        return $vendors;
    }


    public function show(Request $request, $id)
    {

        try {

            $vendorId = $id;
            $vendor = Vendor::with(['menus.products' => function ($query) {
                return $query->where('is_active', 1);
            }, 'categories.sub_categories.products' => function ($query) use ($vendorId) {
                return $query->where('is_active', 1)->where('vendor_id', $vendorId);
            }])->findorfail($id);
            return $vendor;
        } catch (\Exception $ex) {

            return response()->json([
                "message" => $ex->getMessage() ?? "No Vendor Found"
            ], 400);
        }
    }

    public function fullDeatils(Request $request, $id)
    {

        if ((auth()->user()->vendor_id ?? null) != $id) {
            return response()->json([
                "message" => "Unauthorized Access"
            ], 400);
        }

        try {
            $vendor = Vendor::with('earning','menus')->withCount('sales')->findorfail($id);
            $weeklyReport = $this->ordersChart($vendor);
            return response()->json([
                "vendor" => $vendor,
                "total_earnig" => $vendor->earning->amount ?? 0.00,
                "total_orders" => $vendor->sales_count,
                "report" => $weeklyReport,
            ], 200);
        } catch (\Exception $ex) {

            return response()->json([
                "message" => $ex->getMessage() ?? "No Vendor Found"
            ], 400);
        }
    }

    public function ordersChart($vendor)
    {

        $report = [];
        for ($loop = 0; $loop < 7; $loop++) {
            $date = Carbon::now()->startOfWeek()->addDays($loop);
            $formattedDate = $date->format("D");
            $data = Order::where('vendor_id', $vendor->id)->whereDate("created_at", $date)->count();

            array_push($report, ["date" => $formattedDate, "value" => $data]);
        }

        return $report;
    }
}
