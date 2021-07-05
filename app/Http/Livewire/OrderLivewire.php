<?php

namespace App\Http\Livewire;

use App\Models\Order;
use App\Models\User;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class OrderLivewire extends BaseLivewireComponent
{

    //
    public $model = Order::class;

    //
    public $orderId;
    public $deliveryBoys;
    public $deliveryBoyId;
    public $status;
    public $paymentStatus;
    public $note;

    //
    public $orderStatus;
    public $orderPaymentStatus;


    public function render()
    {
        $this->deliveryBoys = User::role('driver')->get();

        //if vendor has any personal delivery boy, use that list instead
        if (!empty(Auth::user()->vendor_id)) {
            $personalDrivers = User::role('driver')->where('vendor_id', Auth::user()->vendor_id)->get();
            if (!empty($personalDrivers)) {
                $this->deliveryBoys = $personalDrivers;
            }
        }

        $this->orderStatus = $this->orderStatus();
        $this->orderPaymentStatus = $this->orderPaymentStatus();
        return view('livewire.orders');
    }

    public function showDetailsModal($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->orderId = $id;
        $this->showDetails = true;
    }

    // Updating model
    public function initiateEdit($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->deliveryBoyId = $this->selectedModel->driver_id;
        $this->status = $this->selectedModel->status;
        $this->paymentStatus = $this->selectedModel->payment_status;
        $this->note = $this->selectedModel->note;
        $this->emit('showEditModal');
    }


    public function update()
    {

        try {

            DB::beginTransaction();
            $this->selectedModel->driver_id = $this->deliveryBoyId;
            $this->selectedModel->status = $this->status;
            $this->selectedModel->payment_status = $this->paymentStatus;
            $this->selectedModel->note = $this->note;
            $this->selectedModel->save();
            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Order updated successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Order update failed!");
        }
    }



    //reivew payment
    public function reviewPayment($id)
    {
        //
        $this->selectedModel = $this->model::find($id);
        $this->emit('showAssignModal');
    }

    public function approvePayment()
    {
        //
        try {

            DB::beginTransaction();
            $this->selectedModel->payment_status = "successful";
            $this->selectedModel->save();
            //
            $this->selectedModel->payment->status = "successful";
            $this->selectedModel->payment->save();
            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Order updated successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Order update failed!");
        }
    }
}
