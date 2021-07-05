<?php

namespace App\Http\Livewire\Tables;


use App\Models\PaymentMethod;
use App\Models\VendorPaymentMethod;
use Kdion4891\LaravelLivewireTables\Column;

class VendorPaymentMethodTable extends BaseTableComponent
{

    public $model = VendorPaymentMethod::class;
    public $header_view = 'components.buttons.new';
    public $sort_attribute = 'payment_method.id';

    public function query()
    {
        return VendorPaymentMethod::with('payment_method')->where('vendor_id', \Auth::user()->vendor_id)->orderBy('payment_method_id');
    }

    public function columns()
    {
        return [
            Column::make('ID','payment_method.id'),
            Column::make('Name','payment_method.name')->searchable(),
            Column::make('Actions')->view('components.buttons.delete'),
        ];
    }
}
