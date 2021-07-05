<?php

namespace App\Http\Livewire\Tables;

use App\Models\Payout;
use Kdion4891\LaravelLivewireTables\Column;
use Illuminate\Support\Facades\Auth;

class PayoutTable extends BaseTableComponent
{

    public $model = Payout::class;
    public $type;


    public function mount()
    {

        //
        $this->setTableProperties();
    }


    public function query()
    {
        $vendorId = \Auth::user()->vendor_id;
        return Payout::with('user', 'earning.user', 'earning.vendor')->when($this->type == "vendors", function ($query) {
            return $query->whereHas('earning', function ($query) {
                return $query->whereNotNull('vendor_id')->when(\Auth::user()->hasAnyRole('city-admin'), function ($query) {
                    return $query->whereHas("vendor", function ($query) {
                        return $query->where('creator_id', Auth::id());
                    });
                });
            });
        }, function ($query) use ($vendorId) {
            return $query->whereHas('earning', function ($query) use ($vendorId) {
                return $query->whereNotNull('user_id')->when($vendorId, function ($query) use ($vendorId) {
                    return $query->whereHas("user", function ($q) use ($vendorId) {
                        return $q->where('vendor_id', $vendorId);
                    });
                })->when(\Auth::user()->hasAnyRole('city-admin'), function ($query) {
                    return $query->whereHas("user", function ($query) {
                        return $query->where('creator_id', Auth::id());
                    });
                });;
            });
        });
    }

    public function columns()
    {

        $columns = [
            Column::make('ID'),
            Column::make('Amount')->view('components.table.price')->searchable()->sortable(),
        ];


        if ($this->type == "vendors") {
            array_push($columns, Column::make('Vendor', 'earning.vendor.name')->searchable());
        } else {
            array_push($columns, Column::make('Driver', 'earning.user.name')->searchable());
        }

        array_push($columns, Column::make('Paid By', 'user.name'));
        array_push($columns, Column::make('Paid On', 'formatted_date'));
        return $columns;
    }
}
