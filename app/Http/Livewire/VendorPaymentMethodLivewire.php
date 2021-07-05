<?php

namespace App\Http\Livewire;

use App\Models\PaymentMethod;
use Exception;
use Illuminate\Support\Facades\DB;
use App\Models\VendorPaymentMethod;

class VendorPaymentMethodLivewire extends BaseLivewireComponent
{

    //
    public $model = VendorPaymentMethod::class;
    public $paymentMethodIds;

    public function render()
    {
        return view('livewire.vendor-payment-methods',[
            "paymentMethods" => PaymentMethod::active()->get()
        ]);
    }

    public function showCreateModal()
    {
        $this->reset();
        $this->showCreate = true;
        $this->paymentMethodIds = VendorPaymentMethod::where('vendor_id',\Auth::user()->vendor_id)->get()->pluck('payment_method_id');
        $this->showSelect2("#paymentMethodSelect2", $this->paymentMethodIds, "paymentMethodsChange");
    }

    public function paymentMethodsChange($data)
    {
        $this->paymentMethodIds = $data;
    }

    public function assignPaymentMethods(){
        try {

            $vendorId = \Auth::user()->vendor_id;
            DB::beginTransaction();
            //remove all vendor payment methods
            VendorPaymentMethod::where('vendor_id', $vendorId)->delete();
            

            //assigning
            foreach ($this->paymentMethodIds as $paymentMethodId) {
                $vendorPaymentMethod = new VendorPaymentMethod();
                $vendorPaymentMethod->payment_method_id = $paymentMethodId;
                $vendorPaymentMethod->vendor_id = $vendorId;
                $vendorPaymentMethod->save();
            }

            DB::commit();
            $this->emit('dismissModal');
            $this->emit('refreshTable');
            $this->showSuccessAlert("Payment Methods assigned successfully!");
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Payment Methods assignment failed!");
        }
    }

    
}
