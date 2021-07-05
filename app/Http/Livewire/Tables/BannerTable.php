<?php

namespace App\Http\Livewire\Tables;

use App\Models\Banner;
use Kdion4891\LaravelLivewireTables\Column;

class BannerTable extends BaseTableComponent
{

    public $model = Banner::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return Banner::with('category');
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Category','category.name')->searchable(),
            Column::make('Image')->view('components.table.image_md'),
            Column::make('Active')->view('components.table.active'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.actions'),
        ];
    }
}
