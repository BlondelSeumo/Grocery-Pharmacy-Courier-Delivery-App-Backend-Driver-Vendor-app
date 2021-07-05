<?php

namespace App\Http\Livewire\Tables;

use App\Models\CityVendor;
use Kdion4891\LaravelLivewireTables\Column;
use Illuminate\Support\Facades\Auth;

class VendorCityTable extends BaseTableComponent
{

    public $model = CityVendor::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return CityVendor::with('city.state.country','vendor')->where('vendor_id', Auth::user()->vendor_id );
    }

    public function columns()
    {
        return [
            Column::make('ID')->sortable(),
            Column::make('Name','city.name')->searchable()->sortable(),
            Column::make('State',"city.state.name")->searchable(),
            Column::make('Country',"city.state.country.name")->searchable(),
            Column::make('Active')->view('components.table.active'),
            Column::make('Actions')->view('components.buttons.actions'),
        ];
    }
}
