<?php

namespace App\Traits;

use App\Models\Payment;
use App\Models\PaymentMethod;
use App\Models\Wallet;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

trait BillplzTrait
{


    public function createBillplzPaymentReference($order)
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
            $payment->save();


            //get collection id
            $billPlzCreateCollectionId = $this->billPlzCreateCollection($order->payment_method);
            //create bill
            $response = Http::withBasicAuth($paymentMethod->secret_key . ':', '')
                ->post(
                    '' . $this->billPlzApi() . '/v3/bills',
                    [
                        "collection_id" => $billPlzCreateCollectionId,
                        "email" => $order->user->email,
                        "name" => $order->user->name,
                        "amount" => $order->total * 100,
                        "callback_url" => route('payment.callback', ["code" => $order->code, "status" => "success"]),
                        "redirect_url" => route('payment.callback', ["code" => $order->code, "status" => "success"]),
                        "description" => "Order payment",
                    ]
                );
            $payment->ref = $response->json()["id"];
            $payment->session_id = $response->json()["url"];
            $payment->save();

            return $payment->session_id;
        } else {
            $paymentlink = $order->payment->session_id;
        }
        return $paymentlink;
    }

    public function createBillplzTopupReference($walletTransaction, $paymentMethod)
    {
        //
        //get collection id
        $billPlzCreateCollectionId = $this->billPlzCreateCollection($paymentMethod);
        //create bill
        $response = Http::withBasicAuth($paymentMethod->secret_key . ':', '')
            ->post(
                '' . $this->billPlzApi() . '/v3/bills',
                [
                    "collection_id" => $billPlzCreateCollectionId,
                    "email" => $walletTransaction->wallet->user->email,
                    "name" => $walletTransaction->wallet->user->name,
                    "amount" => $walletTransaction->amount * 100,
                    "callback_url" => route('wallet.topup.callback', ["code" => $walletTransaction->ref, "status" => "success"]),
                    "redirect_url" => route('wallet.topup.callback', ["code" => $walletTransaction->ref, "status" => "success"]),
                    "description" => "Wallet topup payment",
                ]
            );
        
        $walletTransaction->session_id = $response->json()["id"];
        $walletTransaction->payment_method_id = $paymentMethod->id;
        $walletTransaction->save();

        return $response->json()["url"];
    }


    public function verifyBillplzTransaction($order)
    {
        $paymentMethod = $order->payment_method;

        //create bill
        $billplzBill = Http::withBasicAuth($paymentMethod->secret_key . ':', '')
            ->get('' . $this->billPlzApi() . '/v3/bills/' . $order->payment->ref . '');

        if ($billplzBill['paid']) {

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


    public function verifyBillplzTopupTransaction($walletTransaction)
    {
        $paymentMethod = $walletTransaction->payment_method;

        //create bill
        $billplzBill = Http::withBasicAuth($paymentMethod->secret_key . ':', '')
            ->get('' . $this->billPlzApi() . '/v3/bills/' . $walletTransaction->session_id . '');

        if ($billplzBill['paid']) {

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















    ///
    private function billPlzApi()
    {
        if (!App::environment('production')) {

            return 'https://www.billplz-sandbox.com/api';
        } else {
            return 'https://www.billplz.com/api';
        }
    }

    private function billPlzCreateCollection(PaymentMethod $paymentMethod)
    {
        $billzCollectionId = setting("billzCollectionId", "");
        if (empty($billzCollectionId)) {
            $response = Http::withBasicAuth($paymentMethod->secret_key . ':', '')->post('' . $this->billPlzApi() . '/v3/collections', [
                "title" => "Payment",
            ]);
            setting([
                'billzCollectionId' =>  $response->json()["id"] ?? "",
            ])->save();
        }

        return $billzCollectionId;
    }
}
