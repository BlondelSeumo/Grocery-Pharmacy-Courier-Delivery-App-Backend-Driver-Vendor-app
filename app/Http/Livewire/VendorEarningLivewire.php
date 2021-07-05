<?php

namespace App\Http\Livewire;

use App\Models\Earning;
use App\Models\PaymentMethod;
use App\Models\Payout;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class VendorEarningLivewire extends BaseLivewireComponent
{

    //
    public $model = Earning::class;

    //
    public $amount;
    public $payment_method_id;
    public $note;
    public $type;

    public function render()
    {

        $this->type = "vendors";
        $paymentMethods = PaymentMethod::active()->get();
        $this->payment_method_id = $paymentMethods->first()->id;
        return view('livewire.earnings',[
            "paymentMethods" => $paymentMethods
        ]);
    }


    public function initiatePayout($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->emit('showCreateModal');
    }

    public function payout()
    {
        //validate
        $this->validate(
            [
                "amount" => "required|numeric|max:".$this->selectedModel->amount."",
            ]
        );

        try {

            DB::beginTransaction();
            $payout = new Payout();
            $payout->earning_id = $this->selectedModel->id;
            $payout->payment_method_id = $this->payment_method_id;
            $payout->user_id = Auth::id();
            $payout->amount = (double)$this->amount;
            $payout->note = $this->note;
            $payout->save();

            //reduce the earning
            $this->selectedModel->amount -= $this->amount;
            $this->selectedModel->Save();

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Payout created successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            logger($error);
            $this->showErrorAlert($error->getMessage() ?? "Payout creation failed!");
        }
    }
}
