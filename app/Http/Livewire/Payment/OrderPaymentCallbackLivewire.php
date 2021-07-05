<?php

namespace App\Http\Livewire\Payment;

use App\Models\Order;
use App\Http\Livewire\BaseLivewireComponent;
use App\Traits\BillplzTrait;
use App\Traits\FlutterwaveTrait;
use App\Traits\PaystackTrait;
use App\Traits\RazorPayTrait;
use App\Traits\StripeTrait;
use App\Traits\AbitmediaTrait;
use App\Traits\PaypalTrait;

class OrderPaymentCallbackLivewire extends BaseLivewireComponent
{

    use StripeTrait, RazorPayTrait, PaystackTrait, FlutterwaveTrait, BillplzTrait, AbitmediaTrait;
    use PaypalTrait;

    public $code;
    public $status;
    public $transaction_id;
    public $error;
    public $errorMessage;
    protected $queryString = ['code', 'status', 'transaction_id'];



    public function mount()
    {
        $this->selectedModel = Order::where('code', $this->code)->first();
        //
        if (empty($this->selectedModel)) {
        } else {

            try {
                if ($this->selectedModel->payment_method->slug == "stripe") {
                    $this->verifyStripeTransaction($this->selectedModel);
                } else if ($this->selectedModel->payment_method->slug == "razorpay") {
                    $this->verifyRazorpayTransaction($this->selectedModel);
                } else if ($this->selectedModel->payment_method->slug == "paystack") {
                    $this->verifyPaystackTransaction($this->selectedModel);
                } else if ($this->selectedModel->payment_method->slug == "flutterwave") {
                    $this->verifyFlutterwaveTransaction($this->selectedModel, $this->transaction_id);
                } else if ($this->selectedModel->payment_method->slug == "billplz") {
                    $this->verifyBillplzTransaction($this->selectedModel);
                } else if ($this->selectedModel->payment_method->slug == "abitmedia") {
                    $this->verifyAbitmediaTransaction($this->selectedModel, $this->transaction_id);
                } else if ($this->selectedModel->payment_method->slug == "paypal") {
                    $this->verifyPaypalTransaction($this->selectedModel, $this->transaction_id);
                }
                $this->error = false;
            } catch (\Exception $ex) {
                $this->error = true;
                $this->errorMessage = $ex->getMessage();
            }
        }
    }

    public function render()
    {

        //
        if (empty($this->selectedModel)) {
            return view('livewire.payment.invalid')->layout('layouts.guest');
        } else {
            return view('livewire.payment.callback')->layout('layouts.guest');
        }
    }
}
