<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Favourite;
use App\Models\Coupon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CouponController extends Controller
{

    public function index(Request $request){
        return Coupon::get();
    }

    public function show(Request $request, $code){

        try{

            $coupon = Coupon::with('products', 'vendors')->where('code', "=", $code)->firstorfail();
            return response()->json( $coupon, 200);

        }catch(\Exception $ex){
            return response()->json([
                "message" => "No Coupon Found"
            ], 400);
        }
    }

}
