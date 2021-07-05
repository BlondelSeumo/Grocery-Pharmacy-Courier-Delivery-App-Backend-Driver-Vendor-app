<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Favourite;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class FavouriteController extends Controller
{

    public function index(Request $request){
        $favourites = Favourite::with('product.options')->where('user_id', "=", Auth::id())->get();
        return $favourites;
    }

    public function store(Request $request){

        try{

            $model = Favourite::where('user_id', Auth::id())->where('product_id', $request->product_id)->first();
            if( !empty($model) ){
                return response()->json([
                    "message" => "Product already Favourite"
                ], 400);
            }

            $model = new Favourite();
            $model->user_id = Auth::id();
            $model->product_id = $request->product_id;
            $model->save();

            return response()->json([
                "message" => "Favourite added successfully"
            ], 200);

        }catch(\Exception $ex){

            return response()->json([
                "message" => "No Favourite Found"
            ], 400);

        }

    }

    public function destroy(Request $request, $id){

        try{

            Favourite::where('user_id', "=", Auth::id())->where('product_id', "=", $id)->firstorfail()->delete();
            return response()->json([
                "message" => "Favourite deleted successfully"
            ], 200);

        }catch(\Exception $ex){
            return response()->json([
                "message" => "No Favourite Found"
            ], 400);
        }
    }

}
