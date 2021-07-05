<?php

namespace App\Http\Livewire\Tables;


use App\Models\PaymentMethod;
use Kdion4891\LaravelLivewireTables\Column;

class PaymentMethodTable extends BaseTableComponent
{

    public $model = PaymentMethod::class;

    public function query()
    {
        return PaymentMethod::query();
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Image')->view('components.table.image_sm'),
            Column::make('Active')->view('components.table.active'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.actions'),
        ];
    }
}
