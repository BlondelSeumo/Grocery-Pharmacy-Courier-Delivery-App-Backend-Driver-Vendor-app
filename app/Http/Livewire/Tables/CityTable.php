<?php

namespace App\Http\Livewire\Tables;

use App\Models\City;
use Kdion4891\LaravelLivewireTables\Column;

class CityTable extends BaseTableComponent
{

    public $model = City::class;
    public $per_page = 100;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return City::with('state.country');
    }

    public function columns()
    {
        return [
            Column::make('ID')->sortable(),
            Column::make('Name','name')->searchable()->sortable(),
            Column::make('State',"state.name")->searchable(),
            Column::make('Country',"state.country.name")->searchable(),
            Column::make('Actions')->view('components.buttons.edit'),
        ];
    }
}
