<?php

namespace App\Http\Livewire\Tables;

use App\Models\Category;
use Kdion4891\LaravelLivewireTables\Column;

class CategoryTable extends BaseTableComponent
{

    public $model = Category::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return Category::query();
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Image')->view('components.table.image_md'),
            Column::make('Active')->view('components.table.active'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.actions'),
        ];
    }
}
