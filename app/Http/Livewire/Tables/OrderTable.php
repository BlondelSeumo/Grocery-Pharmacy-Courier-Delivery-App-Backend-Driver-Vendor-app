<?php

namespace App\Http\Livewire\Tables;

use App\Models\Order;
use App\Models\User;
use Kdion4891\LaravelLivewireTables\Column;
use Illuminate\Support\Facades\Auth;


class OrderTable extends BaseTableComponent
{


    public function query()
    {

        $user = User::find(Auth::id());
        if ($user->hasRole('admin')) {
            return Order::fullData()->orderBy('updated_at', "DESC");
        } else if ($user->hasRole('city-admin')) {
            return Order::with('vendor')->whereHas("vendor", function ($query) {
                return $query->where('creator_id', Auth::id());
            })->fullData()->orderBy('updated_at', "DESC");
        } else {
            return Order::fullData()->where('vendor_id', Auth::user()->vendor_id)->orderBy('updated_at', "DESC");
        }
    }

    public function columns()
    {
        return [
            Column::make('ID'),
            Column::make('Code', 'code')->searchable()->sortable(),
            Column::make('User', 'user.name')->searchable()->sortable(),
            Column::make('Status')->searchable()->sortable(),
            Column::make('Payment Status')->searchable()->sortable(),
            Column::make('Total')->view('components.table.order-total')->searchable()->sortable(),
            Column::make('Method', 'payment_method.name')->searchable(),
            Column::make('Type', 'formatted_type'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.order_actions'),
        ];
    }
}
