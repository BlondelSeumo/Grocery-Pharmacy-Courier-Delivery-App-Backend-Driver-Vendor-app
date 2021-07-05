<?php

namespace App\Http\Livewire\Payment;

use App\Http\Livewire\BaseLivewireComponent;
use App\Models\PaymentMethod;
use App\Models\WalletTransaction;
use App\Traits\FlutterwaveTrait;
use App\Traits\PaystackTrait;
use App\Traits\RazorPayTrait;
use App\Traits\StripeTrait;
use App\Traits\BillplzTrait;
use App\Traits\AbitmediaTrait;
use App\Traits\PaypalTrait;

class WalletTopUpLivewire extends BaseLivewireComponent
{
    use StripeTrait, RazorPayTrait, PaystackTrait, FlutterwaveTrait, BillplzTrait, AbitmediaTrait;
    use PaypalTrait;

    public $code;
    public $error;
    public $errorMessage;
    public $done = false;
    public $currency;
    public $paymentStatus;
    public $selectedPaymentMethod;
    protected $queryString = ['code'];
    //
    public $paymentCode;


    public function mount()
    {
        $this->selectedModel = WalletTransaction::with('wallet.user', 'payment_method')->where('ref', $this->code)->first();
    }

    public function render()
    {
        //
        if (!in_array($this->selectedModel->status, ['pending'])) {
            return view('livewire.payment.processed')->layout('layouts.guest');
        } else {
            return view('livewire.payment.wallet', [
                "transaction" => $this->selectedModel,
                "paymentMethods" => PaymentMethod::active()->topUp()->get(),
                'paypalMethod' => PaymentMethod::where('slug', 'paypal')->first(),
            ])->layout('layouts.guest');
        }
    }

    //
    public function initPayment($id)
    {

        $this->selectedPaymentMethod = PaymentMethod::find($id);
        $paymentMethodSlug = $this->selectedPaymentMethod->slug;

        if ($paymentMethodSlug == "stripe") {
            $session = $this->createStripeTopupSession($this->selectedModel, $this->selectedPaymentMethod);
            $this->emit('initStripe', [
                $this->selectedPaymentMethod->public_key,
                $session,
            ]);
        } else if ($paymentMethodSlug == "razorpay") {
            //initialize razorpay payment order
            $razorpayOrderId = $this->createRazorpayTopupReference($this->selectedModel, $this->selectedPaymentMethod);
            //
            $this->emit('initRazorpay', [
                $this->selectedPaymentMethod->public_key,
                $this->selectedModel->amount * 100,
                setting('currencyCode', 'INR'),
                setting('websiteName', env("APP_NAME")),
                setting('websiteLogo', asset('images/logo.png')),
                $razorpayOrderId,
                route('wallet.topup.callback', ["code" => $this->selectedModel->ref, "status" => "success"]),
            ]);
        } else if ($paymentMethodSlug == "paystack") {
            //initialize razorpay payment order
            $paymentRef = $this->createPaystackTopupReference($this->selectedModel, $this->selectedPaymentMethod);
            //
            $this->emit('initPaystack', [
                $this->selectedPaymentMethod->public_key,
                $this->selectedModel->wallet->user->email,
                $this->selectedModel->amount * 100,
                setting('currencyCode', 'USD'),
                $paymentRef,
                route('wallet.topup.callback', ["code" => $this->selectedModel->ref, "status" => "success"]),
            ]);
        } else if ($paymentMethodSlug == "flutterwave") {
            //initialize razorpay payment order
            $paymentRef = $this->createFlutterwaveTopupReference($this->selectedModel, $this->selectedPaymentMethod);
            //
            $this->emit('initFlwPayment', [
                $this->selectedPaymentMethod->public_key,
                $paymentRef,
                $this->selectedModel->amount,
                setting('currencyCode', 'USD'),
                //country code
                setting('currencyCountryCode', 'US'),
                route('wallet.topup.callback', ["code" => $this->selectedModel->ref, "status" => "success"]),
                //customer info
                [
                    $this->selectedModel->wallet->user->email,
                    $this->selectedModel->wallet->user->phone,
                    $this->selectedModel->wallet->user->name,
                ],
                //company info
                [
                    setting('websiteName', env("APP_NAME")),
                    setting('websiteLogo', asset('images/logo.png')),
                ],
            ]);
        } else if ($paymentMethodSlug == "billplz") {
            //initialize razorpay payment order
            $paymentLink = $this->createBillplzTopupReference($this->selectedModel, $this->selectedPaymentMethod);
            return redirect()->away($paymentLink);
        } else if ($paymentMethodSlug == "abitmedia") {
            //initialize razorpay payment order
            $paymentLink = $this->createAbitmediaTopupReference($this->selectedModel, $this->selectedPaymentMethod);
            return redirect()->away($paymentLink);
        } else if ($paymentMethodSlug == "paypal") {
            //initialize paypal payment order
            $this->emit('initPaypalPayment', [
                $this->selectedModel->amount,
                setting('currencyCode', 'USD'),
                route('wallet.topup.callback', ["code" => $this->selectedModel->ref, "status" => "success"]),
            ]);
        }
    }

    public function saveOfflinePayment()
    {
        $this->validate(
            [
                "paymentCode" => "required",
                "photo" => "required|image|max:4096",
            ]
        );


        try {

            \DB::beginTransaction();
            $this->selectedModel->session_id = $this->paymentCode;
            //payment status
            $this->selectedModel->status = "review";
            $this->selectedModel->payment_method_id = $this->selectedPaymentMethod->id;
            $this->selectedModel->save();

            if ($this->photo) {

                $this->selectedModel->addMedia($this->photo->getRealPath())->toMediaCollection();
                $this->photo = null;
            }

            \DB::commit();
            $this->errorMessage = "Payment info uploaded successfully. You will be notified once approved";
        } catch (Exception $error) {
            \DB::rollback();
            $this->error = true;
            $this->errorMessage = $error->getMessage() ?? "Payment info uploaded failed!";
        }

        $this->done = true;
    }
}
