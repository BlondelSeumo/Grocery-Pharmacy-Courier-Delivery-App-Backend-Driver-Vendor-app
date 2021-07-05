<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\PaymentMethod;
use App\Models\VendorPaymentMethod;
use Illuminate\Http\Request;

class PaymentMethodController extends Controller
{

    public function index(Request $request)
    {

        $vendorId = $request->vendor_id ?? 0;
        $paymentMethods = [];
        $vendorPaymentMethodIds = VendorPaymentMethod::where('vendor_id', $vendorId)->get()->pluck('payment_method_id');
        // logger("vendorPaymentMethodIds", [$vendorPaymentMethodIds]);
        if (!empty($vendorId) && count($vendorPaymentMethodIds) > 0 ) {
            $paymentMethods = PaymentMethod::active()->whereIn('id', $vendorPaymentMethodIds)->get();
            // logger("vPayMethods", [$paymentMethods]);
        }else{
            $paymentMethods = PaymentMethod::active()->get();
            // logger("normal PayMethods", [$paymentMethods]);
        }
        return response()->json([
            "data" => $paymentMethods
        ], 200);
    }
}
