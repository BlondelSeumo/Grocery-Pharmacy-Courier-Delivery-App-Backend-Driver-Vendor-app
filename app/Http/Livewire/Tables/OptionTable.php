<?php

namespace App\Http\Livewire\Tables;

use App\Models\Option;
use Kdion4891\LaravelLivewireTables\Column;
use Illuminate\Support\Facades\Auth;

class OptionTable extends BaseTableComponent
{

    public $model = Option::class;
    public $header_view = 'components.buttons.new';


    public function mount(){

        //
        if( !Auth::user()->hasRole('manager') ){
            $this->header_view = null;
            $this->canManage = false;
        }
        //
        $this->setTableProperties();
    }


    public function query()
    {

        if( !Auth::user()->hasRole('manager') ){
            return Option::with('product.vendor','option_group');
        }else{
            return Option::with('product.vendor','option_group')->where('vendor_id', Auth::user()->vendor_id);
        }
        
    }

    public function columns()
    {

        $columns = [
            Column::make('ID'),
            Column::make('Image')->view('components.table.image_sm'),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Price')->view('components.table.price')->searchable()->sortable(),
            Column::make('Option Group','option_group.name')->searchable()->sortable(),
            Column::make('Product','product.name')->searchable()->sortable(),
            Column::make('Vendor','product.vendor.name')->searchable(),
            Column::make('Active')->view('components.table.active'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.actions')
        ];

        //
        // if( $this->canManage ){
        //     array_push($columns, Column::make('Actions')->view('components.buttons.actions'));
        // }
        return $columns;
    }
}
