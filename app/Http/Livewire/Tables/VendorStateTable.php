<?php

namespace App\Http\Livewire\Tables;

use App\Models\StateVendor;
use Kdion4891\LaravelLivewireTables\Column;
use Illuminate\Support\Facades\Auth;

class VendorStateTable extends BaseTableComponent
{

    public $model = StateVendor::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return StateVendor::with('state.country','vendor')->where('vendor_id', Auth::user()->vendor_id );
    }

    public function columns()
    {
        return [
            Column::make('ID')->sortable(),
            Column::make('Name','state.name')->searchable()->sortable(),
            Column::make('Country',"state.country.name")->searchable(),
            Column::make('Active')->view('components.table.active'),
            Column::make('Actions')->view('components.buttons.actions'),
        ];
    }
}
