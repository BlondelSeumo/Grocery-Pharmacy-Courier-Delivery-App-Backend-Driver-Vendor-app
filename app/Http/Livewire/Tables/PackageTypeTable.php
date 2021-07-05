<?php

namespace App\Http\Livewire\Tables;


use App\Models\PackageType;
use Kdion4891\LaravelLivewireTables\Column;

class PackageTypeTable extends BaseTableComponent
{

    public $model = PackageType::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return PackageType::query();
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Name')->searchable(),
            Column::make('Description'),
            Column::make('Image')->view('components.table.image_md'),
            Column::make('Active')->view('components.table.active'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.actions'),
        ];
    }
}
