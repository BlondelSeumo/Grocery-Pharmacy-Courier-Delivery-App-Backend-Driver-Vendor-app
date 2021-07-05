<?php

namespace App\Traits;

use Razorpay\Api\Api;
use App\Models\Order;
use App\Models\Payment;
use App\Models\Currency;
use App\Models\PaymentMethod;
use App\Models\Wallet;
use Illuminate\Support\Facades\DB;
use Srmklive\PayPal\Services\PayPal as PayPalClient;


trait PaypalTrait
{


    public function getPaypalAccessToekn()
    {

        // Through facade. No need to import namespaces
        $provider = new PayPalClient;
        $provider->setApiCredentials($this->paypalConfig());
        return $provider->getAccessToken();
    }

    public function paypalConfig()
    {
        $paymentMethod = PaymentMethod::where('slug', "paypal")->first();
        return [
            'mode'    => 'sandbox',
            'live' => [
                'client_id'         => $paymentMethod->public_key,
                'client_secret'     => $paymentMethod->secret_key,
                'app_id'            => '',
            ],
            'sandbox' => [
                'client_id'         => $paymentMethod->public_key,
                'client_secret'     => $paymentMethod->secret_key,
                'app_id'            => '',
            ],

            'payment_action' => 'Sale',
            'currency'       => setting('currencyCode', 'USD'),
            'notify_url'     => '',
            'locale'         => 'en_US',
            'validate_ssl'   => true,
        ];
    }


    public function createPaypalPaymentReference($order)
    {

        // if ($order->payment == null || $order->payment->status != "pending") {

        //     // Through facade. No need to import namespaces
        //     $provider = new PayPalClient;
        //     //
        //     $provider->setApiCredentials($this->paypalConfig());
        //     $provider->getAccessToken();

        //     $response = $provider->showOrderDetails($orderId);

        //     logger("Response", [$response]);
        //     // throw new Exception("Error Processing Request", 1);
        //     //
        //     $payment = new Payment();
        //     $payment->order_id = $order->id;
        //     $links = $response["links"];
        //     foreach ($links as $link) {
        //         if ($link["rel"] == "approve") {
        //             $payment->session_id = $link["href"];
        //         }
        //     }
        //     // TODO: check this well
        //     $payment->ref = $response["id"];
        //     $payment->amount = $order->total;
        //     $payment->save();

        //     return $payment->session_id;
        // } else {
        //     return $order->payment->session_id;
        // }
    }

    protected function verifyPaypalTransaction($order, $transactionId)
    {

        $provider = new PayPalClient;
        $provider->setApiCredentials($this->paypalConfig());
        $provider->getAccessToken();
        $response = $provider->showOrderDetails($transactionId);

        if ($response['status'] == "success" || $response['status'] == "COMPLETED") {

            $payment = new Payment();
            $payment->order_id = $order->id;
            $payment->session_id = $transactionId;
            $payment->amount = $order->total;
            $payment->save();

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

    protected function verifyPaypalTopupTransaction($walletTransaction, $transactionId)
    {

        $provider = new PayPalClient;
        $provider->setApiCredentials($this->paypalConfig());
        $provider->getAccessToken();
        $response = $provider->showOrderDetails($transactionId);

        if ($response['status'] == "success" || $response['status'] == "COMPLETED") {

            //has order been paided for before
            if (empty($walletTransaction) || $walletTransaction->status == "successful") {
                throw new \Exception("Wallet Topup is invalid or has already been paid");
            }

            try {
                DB::beginTransaction();
                $walletTransaction->status = "successful";
                $walletTransaction->session_id = $transactionId;
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
