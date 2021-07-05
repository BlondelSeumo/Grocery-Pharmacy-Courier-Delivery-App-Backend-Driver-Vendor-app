<?php

namespace App\Http\Livewire\Tables;

use App\Models\User;
use Kdion4891\LaravelLivewireTables\Column;

class DriverTable extends BaseTableComponent
{

    public $model = User::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return User::role('driver')->where('vendor_id', \Auth::user()->vendor_id);
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
}
