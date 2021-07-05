<?php

namespace App\Http\Livewire\Tables;

use App\Models\Subcategory;
use Kdion4891\LaravelLivewireTables\Column;

class SubCategoryTable extends BaseTableComponent
{

    public $model = Subcategory::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return Subcategory::with('category');
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Category','category.name'),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Image')->view('components.table.image_md'),
            Column::make('Active')->view('components.table.active'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.actions'),
        ];
    }
}
