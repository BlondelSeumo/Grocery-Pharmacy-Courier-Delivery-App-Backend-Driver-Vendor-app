<?php

namespace App\Http\Livewire\Tables;


use App\Models\PackageTypePricing;
use Illuminate\Support\Facades\Auth;
use Kdion4891\LaravelLivewireTables\Column;

class PackageTypePriceTable extends BaseTableComponent
{

    public $model = PackageTypePricing::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return PackageTypePricing::with('package_type')->where('vendor_id', Auth::user()->vendor_id);
    }

    public function columns()
    {
        return [
            Column::make('ID')->sortable(),
            Column::make('Package Type','package_type.name')->searchable(),
            Column::make('Max Booking Days', 'max_booking_days')->sortable(),
            Column::make('Base Price','base_price')->view('components.table.price')->sortable(),
            Column::make('Price for Package','size_price')->view('components.table.price')->sortable(),
            Column::make('Distance Price','distance_price')->view('components.table.price')->sortable(),
            Column::make('Auto Ready','auto_assignment')->view('components.table.bool')->sortable(),
            Column::make('Extra fields', 'field_required')->view('components.table.bool')->sortable(),
            Column::make('Actions')->view('components.buttons.actions'),
        ];
    }
}
