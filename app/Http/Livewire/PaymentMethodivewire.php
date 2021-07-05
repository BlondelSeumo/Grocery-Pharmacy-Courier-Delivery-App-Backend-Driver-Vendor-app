<?php

namespace App\Http\Livewire;

use Exception;
use Illuminate\Support\Facades\DB;
use App\Models\PaymentMethod;
use Brotzka\DotenvEditor\DotenvEditor;

class PaymentMethodivewire extends BaseLivewireComponent
{

    //
    public $model = PaymentMethod::class;

    //
    public $name;
    public $secret_key;
    public $public_key;
    public $hash_key;
    public $instruction;
    public $isActive;

    protected $rules = [
        "name" => "required|string",
    ];


    public function render()
    {
        return view('livewire.payment-methods');
    }

    public function initiateEdit($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->secret_key = $this->selectedModel->secret_key;
        $this->public_key = $this->selectedModel->public_key;
        $this->hash_key = $this->selectedModel->hash_key;
        $this->instruction = $this->selectedModel->instruction;
        $this->isActive = $this->selectedModel->is_active;
        $this->emit('showEditModal');
    }

    public function update()
    {
        //validate
        $this->validate();

        try {

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->name = $this->name;
            $model->secret_key = $this->secret_key;
            $model->public_key = $this->public_key;
            $model->hash_key = $this->hash_key;
            $model->instruction = $this->instruction;
            $model->is_active = $this->isActive;
            $model->save();

            if ($this->photo) {

                $model->clearMediaCollection();
                $model->addMedia($this->photo->getRealPath())->toMediaCollection();
                $this->photo = null;
            }


            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Payment Method updated successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Payment Method updated failed!");
        }
    }
}
