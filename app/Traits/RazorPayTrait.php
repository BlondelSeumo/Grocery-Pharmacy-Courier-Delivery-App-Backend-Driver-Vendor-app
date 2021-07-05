<?php

namespace App\Traits;

use Razorpay\Api\Api;
use App\Models\Order;
use App\Models\Payment;
use App\Models\Wallet;
use Illuminate\Support\Facades\DB;

trait RazorPayTrait
{



    public function createRazorpayPaymentReference($order)
    {

        if ($order->payment == null || $order->payment->status != "pending") {
            $paymentMethod = $order->payment_method;
            $client = new Api($paymentMethod->public_key, $paymentMethod->secret_key);
            $razorPayOrder  = $client->order->create([
                'receipt'         => "" . $order->code . "",
                'amount'          => $order->total * 100,
                'currency'        => "" . setting('currencyCode', 'USD') . "",
            ]);

            //
            $payment = new Payment();
            $payment->order_id = $order->id;
            $payment->session_id = $razorPayOrder->id;
            $payment->ref = $razorPayOrder->id;
            $payment->amount = $order->total;
            $payment->save();

            return $razorPayOrder->id;
        } else {
            return $order->payment->session_id;
        }
    }
    
    public function createRazorpayTopupReference($walletTransaction,$paymentMethod)
    {

        if ( empty($walletTransaction->session_id) && $walletTransaction->status == "pending") {
            
            $client = new Api($paymentMethod->public_key, $paymentMethod->secret_key);
            $razorPayOrder  = $client->order->create([
                'receipt'         => "" . $walletTransaction->ref . "",
                'amount'          => $walletTransaction->amount * 100,
                'currency'        => "" . setting('currencyCode', 'USD') . "",
            ]);

            //
            $walletTransaction->session_id = $razorPayOrder->id;
            $walletTransaction->payment_method_id = $paymentMethod->id;
            $walletTransaction->save();

            return $razorPayOrder->id;
        } else {
            return $walletTransaction->session_id;
        }
    }




    protected function verifyRazorpayTransaction($order)
    {

        $paymentMethod = $order->payment_method;
        $client = new Api($paymentMethod->public_key, $paymentMethod->secret_key);
        $razorpayPayment = $client->order->fetch($order->payment->session_id)->payments()->items[0];

        if ($razorpayPayment->status == "authorized" || $razorpayPayment->status == "captured") {

            $payment = Payment::where('session_id', $order->payment->session_id)->first();
            $order = Order::find($payment->order_id);

            //has order been paided for before
            if (empty($order) || $order->payment_status == "successful") {
                throw new \Exception("Order is invalid or has already been paid");
            }


            try {

                //capture payment
                if (!$razorpayPayment->captured) {
                    $captureResponse = $razorpayPayment->capture(array('amount' => $order->total * 100));
                }
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

    protected function verifyRazorpayTopupTransaction($walletTransaction)
    {

        $paymentMethod = $walletTransaction->payment_method;
        $client = new Api($paymentMethod->public_key, $paymentMethod->secret_key);
        $razorpayPayment = $client->order->fetch($walletTransaction->session_id)->payments()->items[0];
        
        if ($razorpayPayment->status == "authorized" || $razorpayPayment->status == "captured") {


            //has order been paided for before
            if (empty($walletTransaction) || $walletTransaction->status == "successful") {
                throw new \Exception("Wallet Topup is invalid or has already been paid 3");
            }


            try {

                //capture payment
                if (!$razorpayPayment->captured) {
                    $captureResponse = $razorpayPayment->capture(array('amount' => $walletTransaction->amount * 100));
                }
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
