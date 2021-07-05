<?php

namespace App\Http\Livewire\Tables;

use App\Models\Order;
use App\Models\WalletTransaction;
use Kdion4891\LaravelLivewireTables\Column;
use Illuminate\Support\Facades\Auth;


class WalletTransactionTable extends BaseTableComponent
{

    public $model = WalletTransaction::class;
    public function query()
    {
        return WalletTransaction::with('wallet.user', 'payment_method');
    }

    public function columns()
    {
        return [
            Column::make('ID'),
            Column::make('Image')->view('components.table.image_sm'),
            Column::make('Transaction Code', 'session_id'),
            Column::make('Amount', 'amount')->view('components.table.price')->searchable()->sortable(),
            Column::make('User', 'wallet.user.name')->searchable()->sortable(),
            Column::make('Status')->searchable()->sortable(),
            Column::make('Method', 'payment_method.name'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.transaction_actions'),
        ];
    }


    public function activateModel()
    {

        try {
            \DB::beginTransaction();
            $this->selectedModel->status = "successful";
            $this->selectedModel->save();
            //update wallet balance
            $this->selectedModel->wallet->balance += $this->selectedModel->amount;
            $this->selectedModel->wallet->save();
            \DB::commit();
            $this->showSuccessAlert("Activated");
        } catch (Exception $error) {
            \DB::rollback();
            $this->showErrorAlert("Failed");
        }
    }


    public function deactivateModel()
    {

        try {
            \DB::beginTransaction();
            $this->selectedModel->status = "failed";
            $this->selectedModel->save();
            \DB::commit();
            $this->showSuccessAlert("Deactivated");
        } catch (Exception $error) {
            $this->showErrorAlert("Failed");
        }
    }
}
