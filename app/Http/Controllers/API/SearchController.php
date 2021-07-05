<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Vendor;

class SearchController extends Controller
{
    //
    public function index(Request $request)
    {

        $products = [];

        $products = Product::active()->when($request->type == "best", function ($query) {
            return $query->withCount('sales')->orderBy('sales_count', 'DESC');
        })
            ->when($request->type == "you", function ($query) {

                if (auth('sanctum')->user()) {
                    return $query->whereHas('purchases')->withCount('purchases')->orderBy('purchases_count', 'DESC');
                } else {
                    return $query->inRandomOrder();
                }
            })
            ->when($request->keyword, function ($query) use ($request) {
                return $query->where('name', "like", "%" . $request->keyword . "%");
            })
            ->when($request->category_id, function ($query) use ($request) {
                return $query->whereHas("categories", function ($query) use ($request) {
                    return $query->where('category_id', "=", $request->category_id);
                });
            })
            ->get();



        //
        $latitude = $request->latitude;
        $longitude = $request->longitude;

        $vendors = Vendor::active()->when($latitude, function ($query) use ($latitude, $longitude) {
            return $query->distance($latitude, $longitude)
                ->havingRaw("delivery_range >= distance");
        })
            ->when($request->keyword, function ($query) use ($request) {
                return $query->where('name', "like", "%" . $request->keyword . "%");
            })
            ->when($request->is_open, function ($query) use ($request) {
                return $query->where('is_open', "=", $request->is_open);
            })
            ->when($request->category_id, function ($query) use ($request) {
                return $query->whereHas("categories", function ($query) use ($request) {
                    return $query->where('category_id', "=", $request->category_id);
                });
            })->get();

        //
        return response()->json([
            "products" => $products,
            "vendors" => empty($request->type) ? $vendors : [],
        ], 200);
    }
}
