<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class OrderPaymentCallbackController extends Controller
{

    public function order(Request $request)
    {

        $status = "success";
        if (!in_array($request->status, ["Pagado", "Autorizada"])) {
            $status = "failed";
        }
        return redirect()->route('payment.callback', ["code" => $request->code, "status" => $status, "transaction_id" => $request->reference]);
    }

    public function wallet(Request $request)
    {

        $status = "success";
        if (!in_array($request->status, ["Pagado", "Autorizada"])) {
            $status = "failed";
        }
        return redirect()->route('wallet.topup.callback', ["code" => $request->code, "status" => $status, "transaction_id" => $request->reference]);
    }
}
