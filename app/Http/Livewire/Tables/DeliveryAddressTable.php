<?php

namespace App\Http\Livewire\Tables;

use App\Models\DeliveryAddress;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Kdion4891\LaravelLivewireTables\Column;

class DeliveryAddressTable extends BaseTableComponent
{

    public function query()
    {
        return DeliveryAddress::with('user');
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable(),
            Column::make('Name')->searchable(),
            Column::make('Address')->searchable(),
            Column::make('Latitude'),
            Column::make('Longitude'),
            Column::make('User','user.name')->searchable(),
            Column::make('Created At', 'formatted_date'),
        ];
    }
}
