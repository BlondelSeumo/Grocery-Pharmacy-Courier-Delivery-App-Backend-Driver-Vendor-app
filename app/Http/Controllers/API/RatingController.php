<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Review;
use App\Models\Vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RatingController extends Controller
{


    public function store(Request $request)
    {

        try {

            $vendorId = $request->vendor_id;
            $driverId = $request->driver_id;

            if (!empty($vendorId)) {
                $review = Review::where('user_id', Auth::id())
                    ->where([
                        'vendor_id' => $request->vendor_id,
                        'order_id' => $request->order_id
                    ])->first();
                if (!empty($review)) {
                    throw new \Exception("Vendor already rated", 1);
                }

                $model = new Review();
                $model->user_id = Auth::id();
                $model->vendor_id = $request->vendor_id;
                $model->order_id = $request->order_id;
                $model->rating = $request->rating;
                $model->review = $request->review;
                $model->save();

                //
                $vendor = Vendor::find($request->vendor_id);
                $vendor->rate($request->rating);


                return response()->json([
                    "message" => "Vendor rated successfully"
                ], 200);
            } else {
                $review = Review::where('user_id', Auth::id())
                    ->where([
                        'driver_id' => $request->driver_id,
                        'order_id' => $request->order_id
                    ])->first();
                if (!empty($review)) {
                    throw new \Exception("Driver already rated", 1);
                }

                $model = new Review();
                $model->user_id = Auth::id();
                $model->driver_id = $request->driver_id;
                $model->order_id = $request->order_id;
                $model->rating = $request->rating;
                $model->review = $request->review;
                $model->save();

                //
                $driver = User::find($request->driver_id);
                $driver->rate($request->rating);


                return response()->json([
                    "message" => "Driver rated successfully"
                ], 200);
            }
        } catch (\Exception $ex) {

            return response()->json([
                "message" =>  $ex->getMessage() ?? "Rating failed"
            ], 400);
        }
    }
}
