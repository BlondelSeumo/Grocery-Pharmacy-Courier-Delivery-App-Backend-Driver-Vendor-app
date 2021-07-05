<?php

namespace App\Traits;

use App\Models\Payment;
use App\Models\Wallet;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;

trait PaystackTrait
{



    public function createPaystackPaymentReference($order)
    {

        //
        if ($order->payment == null || $order->payment->status != "pending") {

            //
            $ref = Str::random(14);
            $payment = new Payment();
            $payment->order_id = $order->id;
            $payment->session_id = $ref;
            $payment->ref = $ref;
            $payment->amount = $order->total;
            $payment->save();

            return $payment->session_id;
        } else {
            return $order->payment->session_id;
        }
    }

    public function createPaystackTopupReference($walletTransaction,$paymentMethod)
    {

        //
        if ( empty($walletTransaction->session_id) && $walletTransaction->status == "pending") {

            //
            $ref = Str::random(14);
            $walletTransaction->session_id = $ref;
            $walletTransaction->payment_method_id = $paymentMethod->id;
            $walletTransaction->save();            

            return $walletTransaction->session_id;
        } else {
            return $walletTransaction->session_id;
        }
    }



    protected function verifyPaystackTransaction($order)
    {

        $paymentMethod = $order->payment_method;
        $paystackPayment = Http::withToken($paymentMethod->secret_key)
            ->get('https://api.paystack.co/transaction/verify/' . $order->payment->ref . '')
            ->throw()->json();

        if ($paystackPayment['data']['status'] == "success") {

            $payment = Payment::where('session_id', $order->payment->session_id)->first();

            //has order been paided for before
            if (empty($order) || $order->payment_status == "successful") {
                throw new \Exception("Order is invalid or has already been paid");
            }


            try {

                DB::beginTransaction();
                $payment->status = "successful";
                $payment->save();

                $order->payment_status = "successful";
                $order->save();
                DB::commit();
                return;
            } catch (\Exception $ex) {
                throw $ex;
            }
        } else {
            throw new \Exception("Order is invalid or has already been paid");
        }
    }

    protected function verifyPaystackTopupTransaction($walletTransaction)
    {

        $paymentMethod = $walletTransaction->payment_method;
        $paystackPayment = Http::withToken($paymentMethod->secret_key)
            ->get('https://api.paystack.co/transaction/verify/' . $walletTransaction->session_id . '')
            ->throw()->json();

        if ($paystackPayment['data']['status'] == "success") {

            //has order been paided for before
            if (empty($walletTransaction) || $walletTransaction->status == "successful") {
                throw new \Exception("Wallet Topup is invalid or has already been paid");
            }


            try {

                DB::beginTransaction();
                $walletTransaction->status = "successful";
                $walletTransaction->save();

                //
                $wallet = Wallet::find($walletTransaction->wallet->id);
                $wallet->balance += $walletTransaction->amount;
                $wallet->save();
                DB::commit();
                return;
            } catch (\Exception $ex) {
                throw $ex;
            }
        } else {
            throw new \Exception("Wallet Topup is invalid or has already been paid");
        }
    }
}
