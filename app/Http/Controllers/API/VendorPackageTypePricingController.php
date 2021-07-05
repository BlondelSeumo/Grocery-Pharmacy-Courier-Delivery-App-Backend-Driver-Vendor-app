<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\PackageTypePricing;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class VendorPackageTypePricingController extends Controller
{

    public function index()
    {
        return PackageTypePricing::where('vendor_id', Auth::user()->vendor_id)->get();
    }

    public function store(Request $request)
    {

        try {

            DB::beginTransaction();
            PackageTypePricing::updateOrCreate(["package_type_id" => $request->package_type_id], $request->all());
            DB::commit();

            return response()->json([
                "message" => "Package Pricing Set successfully",
            ]);
        } catch (\Exception $ex) {
            DB::rollback();
            return response()->json([
                "message" => $ex->getMessage()
            ], 400);
        }
    }


    public function update(Request $request, $id)
    {
        try {

            DB::beginTransaction();
            $packageTypePricing = PackageTypePricing::find($id);
            $packageTypePricing->update($request->all());
            DB::commit();

            return response()->json([
                "message" => "Package Pricing updated successfully",
            ]);
        } catch (\Exception $ex) {
            DB::rollback();
            return response()->json([
                "message" => $ex->getMessage()
            ], 400);
        }
    }


    public function destroy($id)
    {
        try {

            DB::beginTransaction();
            PackageTypePricing::destroy($id);
            DB::commit();

            return response()->json([
                "message" => "Package Pricing deleted successfully",
            ]);
        } catch (\Exception $ex) {
            DB::rollback();
            return response()->json([
                "message" => $ex->getMessage()
            ], 400);
        }
    }
}
