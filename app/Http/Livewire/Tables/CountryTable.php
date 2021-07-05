<?php

namespace App\Http\Livewire\Tables;

use App\Models\Country;
use Kdion4891\LaravelLivewireTables\Column;

class CountryTable extends BaseTableComponent
{

    public $model = Country::class;
    public $per_page = 40;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return Country::query();
    }

    public function columns()
    {
        return [
            Column::make('ID'),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Actions')->view('components.buttons.edit'),
        ];
    }
}
