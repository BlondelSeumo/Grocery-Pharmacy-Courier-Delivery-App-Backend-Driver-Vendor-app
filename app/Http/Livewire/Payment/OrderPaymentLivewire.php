<?php

namespace App\Http\Livewire\Payment;

use App\Models\Order;
use App\Http\Livewire\BaseLivewireComponent;
use App\Models\Payment;
use App\Traits\FlutterwaveTrait;
use App\Traits\PaystackTrait;
use App\Traits\RazorPayTrait;
use App\Traits\StripeTrait;
use App\Traits\BillplzTrait;
use App\Traits\AbitmediaTrait;
use App\Traits\PaypalTrait;
use Exception;

class OrderPaymentLivewire extends BaseLivewireComponent
{
    use StripeTrait, RazorPayTrait, PaystackTrait, FlutterwaveTrait, BillplzTrait, AbitmediaTrait;
    use PaypalTrait;

    public $code;
    public $error;
    public $errorMessage;
    public $done = false;
    public $currency;
    public $paymentStatus;
    protected $queryString = ['code'];
    //
    public $paymentCode;


    public function render()
    {

        $this->selectedModel = Order::where('code', $this->code)->first();
        $this->paymentStatus = $this->selectedModel->payment_status ?? "";

        //
        if (empty($this->selectedModel)) {
            return view('livewire.payment.invalid')->layout('layouts.auth');
        } else if (!in_array($this->paymentStatus,['pending','review'])) {
            return view('livewire.payment.processed')->layout('layouts.auth');
        } else {
            return view('livewire.payment.order', [
                "order" => $this->selectedModel,
            ])->layout('layouts.guest');
        }
    }


    //
    public function initPayment()
    {

        $paymentMethodSlug = $this->selectedModel->payment_method->slug;

        if ($paymentMethodSlug == "stripe") {
            $session = $this->createStripePaymentSession($this->selectedModel);
            $this->emit('initStripe', [
                $this->selectedModel->payment_method->public_key,
                $session,
            ]);
        } else if ($paymentMethodSlug == "razorpay") {
            //initialize razorpay payment order
            $razorpayOrderId = $this->createRazorpayPaymentReference($this->selectedModel);
            //
            $this->emit('initRazorpay', [
                $this->selectedModel->payment_method->public_key,
                $this->selectedModel->total * 100,
                setting('currencyCode', 'USD'),
                setting('websiteName', env("APP_NAME")),
                setting('websiteLogo', asset('images/logo.png')),
                $razorpayOrderId,
                route('payment.callback', ["code" => $this->selectedModel->code, "status" => "success"]),
            ]);
        } else if ($paymentMethodSlug == "paystack") {
            //initialize razorpay payment order
            $paymentRef = $this->createPaystackPaymentReference($this->selectedModel);
            //
            $this->emit('initPaystack', [
                $this->selectedModel->payment_method->public_key,
                $this->selectedModel->user->email,
                $this->selectedModel->total * 100,
                setting('currencyCode', 'USD'),
                $paymentRef,
                route('payment.callback', ["code" => $this->selectedModel->code, "status" => "success"]),
            ]);
        } else if ($paymentMethodSlug == "flutterwave") {
            //initialize razorpay payment order
            $paymentRef = $this->createFlutterwavePaymentReference($this->selectedModel);
            //
            $this->emit('initFlwPayment', [
                $this->selectedModel->payment_method->public_key,
                $paymentRef,
                $this->selectedModel->total,
                setting('currencyCode', 'USD'),
                //country code
                setting('currencyCountryCode', 'US'),
                route('payment.callback', ["code" => $this->selectedModel->code, "status" => "success"]),
                //customer info
                [
                    $this->selectedModel->user->email,
                    $this->selectedModel->user->phone,
                    $this->selectedModel->user->name,
                ],
                //company info
                [
                    setting('websiteName', env("APP_NAME")),
                    setting('websiteLogo', asset('images/logo.png')),
                ],
            ]);
        } else if ($paymentMethodSlug == "billplz") {
            //initialize razorpay payment order
            $paymentLink = $this->createBillplzPaymentReference($this->selectedModel);
            return redirect()->away($paymentLink);
        } else if ($paymentMethodSlug == "abitmedia") {
            //initialize abitmedia payment order
            $paymentLink = $this->createAbitmediaPaymentReference($this->selectedModel);
            return redirect()->away($paymentLink);
        } else if ($paymentMethodSlug == "paypal") {
            //initialize paypal payment order
            $this->emit('initPaypalPayment', [
                $this->selectedModel->total,
                setting('currencyCode', 'USD'),
                route('payment.callback', ["code" => $this->selectedModel->code, "status" => "success"]),
            ]);
        }
    }

    //
    public function saveOfflinePayment()
    {
        $this->validate(
            [
                "paymentCode" => "required",
                "photo" => "required|image|max:4096",
            ]
        );


        try{

            \DB::beginTransaction();
            $payment = new Payment();
            $payment->order_id = $this->selectedModel->id;
            $payment->ref = $this->paymentCode;
            $payment->status = "review";
            $payment->save();

            //order payment status
            $this->selectedModel->payment_status = "review";
            $this->selectedModel->save();

            if( $this->photo ){

                $payment->addMedia( $this->photo->getRealPath() )->toMediaCollection();
                $this->photo = null;

            }

            \DB::commit();
            $this->errorMessage = "Payment info uploaded successfully. You will be notified once approved";

        }catch(Exception $error){
            \DB::rollback();
            $this->error = true;
            $this->errorMessage = $error->getMessage() ?? "Payment info uploaded failed!";
        }

        $this->done = true;
    }


}
