<?php

namespace App\Traits;

use App\Models\Payment;
use App\Models\Wallet;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;

trait AbitmediaTrait
{


    public function createAbitmediaPaymentReference($order)
    {
        $paymentMethod = $order->payment_method;
        $paymentlink = "";
        //
        if ($order->payment == null || $order->payment->status != "pending") {

            //

            $ref = Str::random(14);
            $payment = new Payment();
            $payment->order_id = $order->id;
            $payment->session_id = $ref;
            $payment->ref = $ref;
            $payment->amount = $order->total;



            //create bill
            $response = Http::withToken($paymentMethod->secret_key)
                ->post(
                    'https://cloud.abitmedia.com/api/payments/create-payment-link',
                    [
                        "amount" => $order->total,
                        "amountWithoutTax" => $order->total,
                        "amountWithTax" => 0.00,
                        "tax" => 0.00,
                        "notifyUrl" => route('api.payment.callback', ["code" => $order->code, "status" => "success"]),
                        "description" => "Order payment",
                    ]
                );

            $payment->ref = $response->json()["data"]["link_id"];
            $payment->session_id = $response->json()["data"]["url"];
            $payment->save();

            return $payment->session_id;
        } else {
            $paymentlink = $order->payment->session_id;
        }
        return $paymentlink;
    }

    public function createAbitmediaTopupReference($walletTransaction, $paymentMethod)
    {
        //
        //get collection id
        $response = Http::withToken($paymentMethod->secret_key)
            ->post(
                'https://cloud.abitmedia.com/api/payments/create-payment-link',
                [
                    "amount" => $walletTransaction->amount,
                    "amountWithoutTax" => $walletTransaction->amount,
                    "amountWithTax" => 0.00,
                    "tax" => 0.00,
                    "notifyUrl" => route('api.wallet.topup.callback', ["code" => $walletTransaction->ref, "status" => "success"]),
                    "description" => "Wallet topup payment",
                ]
            );

        $walletTransaction->session_id = $response->json()["data"]["url"];
        $walletTransaction->payment_method_id = $paymentMethod->id;
        $walletTransaction->save();

        return $walletTransaction->session_id;
    }


    public function verifyAbitmediaTransaction($order, $reference)
    {
        $paymentMethod = $order->payment_method;

        //
        $transactionInfo = Http::withToken($paymentMethod->secret_key)
            ->get('https://cloud.abitmedia.com/api/payments/status-transaction', [
                "reference" => $reference
            ]);

        if ($transactionInfo['status'] == 200 && in_array($transactionInfo['data']['status'], ["Autorizada", "Pagado"])) {

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
            throw new \Exception("Order is invalid or has already been paid -");
        }
    }


    public function verifyAbitmediaTopupTransaction($walletTransaction, $reference)
    {
        $paymentMethod = $walletTransaction->payment_method;

        //
        $transactionInfo = Http::withToken($paymentMethod->secret_key)
            ->get('https://cloud.abitmedia.com/api/payments/status-transaction', [
                "reference" => $reference
            ]);

        if ($transactionInfo['status'] == 200 && in_array($transactionInfo['data']['status'], ["Autorizada", "Pagado"])) {

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
