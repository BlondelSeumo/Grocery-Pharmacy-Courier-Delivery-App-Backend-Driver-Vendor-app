<?php

namespace App\Http\Livewire\Tables;

use App\Models\DeliveryAddress;
use App\Models\User;
use App\Models\Wallet;
use App\Models\WalletTransaction;
use Illuminate\Support\Facades\Auth;
use Kdion4891\LaravelLivewireTables\Column;

class UserTable extends BaseTableComponent
{

    public $model = User::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        $user = User::find(Auth::id());
        if ($user->hasRole('admin')) {
            return User::query();
        } else {
            return User::where('creator_id', Auth::id());
        }
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Email')->searchable()->sortable(),
            Column::make('Phone')->searchable()->sortable(),
            Column::make('Wallet')->view('components.table.wallet'),
            Column::make('Commission(%)', 'commission'),
            Column::make('Role', 'role_name'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.actions'),
        ];
    }

    //
    public function deleteModel()
    {

        try {
            
            $this->isDemo();
            \DB::beginTransaction();
            //
            $walletIds = Wallet::where('user_id', $this->selectedModel->id)->get()->pluck('id');
            DeliveryAddress::whereIn('user_id', [$this->selectedModel->id])->delete();
            WalletTransaction::whereIn('wallet_id', $walletIds)->delete();
            Wallet::whereIn('id', $walletIds)->delete();
            $this->selectedModel = $this->selectedModel->fresh();
            $this->selectedModel->delete();
            \DB::commit();
            $this->showSuccessAlert("Deleted");
        } catch (Exception $error) {
            \DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Failed");
        }
    }
}
