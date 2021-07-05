<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;

class ProductController extends Controller
{

    public function index(Request $request)
    {

        if ($request->type == "vendor") {
            return Product::with("categories","sub_categories","menus")->where('vendor_id', "=", auth('api')->user()->vendor_id)
                ->when($request->keyword, function ($query) use ($request) {
                    return $query->where('name', "like", "%" . $request->keyword . "%");
                })->latest()->paginate($this->perPage);
        }
        return Product::active()->when($request->type == "best", function ($query) {
            return $query->withCount('sales')->orderBy('sales_count', 'DESC');
        })
            ->when($request->keyword, function ($query) use ($request) {
                return $query->where('name', "like", "%" . $request->keyword . "%");
            })
            ->when($request->category_id, function ($query) use ($request) {
                return $query->where('category_id', "=", $request->category_id);
            })
            ->when($request->is_open, function ($query) use ($request) {
                return $query->where('is_open', "=", $request->is_open);
            })
            ->when($request->type == "you", function ($query) {

                if (auth('sanctum')->user()) {
                    return $query->whereHas('purchases')->withCount('purchases')->orderBy('purchases_count', 'DESC');
                } else {
                    return $query->inRandomOrder();
                }
            })
            ->paginate($this->perPage);
    }

    public function show(Request $request, $id)
    {

        try {
            return Product::with(['option_groups' => function ($query) use ($id) {
                $query->with(['options' => function ($q) use ($id) {
                    $q->where('product_id', "=", $id);
                }]);
            }])->findorfail($id);
        } catch (\Exception $ex) {
            return response()->json([
                "message" => $ex->getMessage() ?? "No Product Found"
            ], 400);
        }
    }

    public function store(Request $request)
    {

        $user = User::find(auth('api')->id());
        //
        if (!$user->hasAnyRole('manager') || $user->vendor_id != $request->vendor_id) {
            return response()->json([
                "message" => "You are not allowed to perform this operation"
            ], 400);
        }

        try {
            \DB::beginTransaction();
            $product = Product::create($request->all());
            $product->deliverable = $request->deliverable == 1 || $request->deliverable == "true";
            $product->is_active = $request->is_active == 1 || $request->is_active == "true";
            $product->save();

            //categories 
            if (!empty($request->category_ids)) {
                $product->categories()->attach($request->category_ids);
            }
            //sub_category_ids 
            if (!empty($request->sub_category_ids)) {
                $product->sub_categories()->attach($request->sub_category_ids);
            }
            //menus
            if (!empty($request->menu_ids)) {
                $product->menus()->attach($request->menu_ids);
            }


            if ($request->hasFile("photo")) {
                $product->clearMediaCollection();
                $product->addMedia($request->photo->getRealPath())->toMediaCollection();
            }

            \DB::commit();
            return response()->json([
                "message" => "Product Added successfully"
            ], 200);
        } catch (\Exception $ex) {
            \DB::rollback();
            return response()->json([
                "message" => $ex->getMessage() ?? "Product Creation failed"
            ], 400);
        }
    }

    public function update(Request $request, $id)
    {


        try {

            $product = Product::find($id);
            $user = User::find(auth('api')->id());
            //
            if (!$user->hasAnyRole('manager') || $user->vendor_id != $product->vendor_id) {
                return response()->json([
                    "message" => "You are not allowed to perform this operation"
                ], 400);
            }

            \DB::beginTransaction();
            $product->update($request->all());

            //categories 
            if (!empty($request->category_ids)) {
                $product->categories()->sync($request->category_ids);
            }
            //sub_category_ids 
            if (!empty($request->sub_category_ids)) {
                $product->sub_categories()->sync($request->sub_category_ids);
            }
            //menus
            if (!empty($request->menu_ids)) {
                $product->menus()->sync($request->menu_ids);
            }


            if ($request->hasFile("photo")) {
                $product->clearMediaCollection();
                $product->addMedia($request->photo->getRealPath())->toMediaCollection();
            }

            \DB::commit();

            return response()->json([
                "message" => "Product updated successfully",
            ]);
        } catch (\Exception $ex) {
            \DB::rollback();
            return response()->json([
                "message" => $ex->getMessage()
            ], 400);
        }
    }

    public function destroy($id)
    {

        $product = Product::find($id);
        $user = User::find(auth('api')->id());
        //
        if (!$user->hasAnyRole('manager') || $user->vendor_id != $product->vendor_id) {
            return response()->json([
                "message" => "You are not allowed to perform this operation"
            ], 400);
        }

        try {

            \DB::beginTransaction();
            Product::destroy($id);
            \DB::commit();

            return response()->json([
                "message" => "Product deleted successfully",
            ]);
        } catch (\Exception $ex) {
            \DB::rollback();
            return response()->json([
                "message" => $ex->getMessage()
            ], 400);
        }
    }
}
