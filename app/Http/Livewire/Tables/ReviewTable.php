<?php

namespace App\Http\Livewire\Tables;

use App\Models\Review;
use Kdion4891\LaravelLivewireTables\Column;

class ReviewTable extends BaseTableComponent
{

    public $model = Review::class;

    public function query()
    {
        return Review::with('user','driver','vendor');
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Vendor','vendor.name')->searchable()->sortable(),
            Column::make('User', 'user.name')->searchable()->sortable(),
            Column::make('Driver', 'driver.name')->searchable()->sortable(),
            Column::make('Rating')->sortable(),
            Column::make('Review'),
            Column::make('Created At', 'formatted_date'),
        ];
    }


}
