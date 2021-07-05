<?php

namespace App\Http\Livewire\Tables;

use App\Models\OptionGroup;
use Kdion4891\LaravelLivewireTables\Column;
use Illuminate\Support\Facades\Auth;

class OptionsGroupTable extends BaseTableComponent
{

    public $model = OptionGroup::class;
    public $header_view = 'components.buttons.new';

    public function mount()
    {
        if (!Auth::user()->hasRole('manager')) {
            $this->header_view = null;
            $this->canManage = false;
        }

        //
        $this->setTableProperties();
    }

    public function query()
    {
        
        if( !Auth::user()->hasRole('manager') ){
            return OptionGroup::query();
        }else{
            return OptionGroup::where('vendor_id', Auth::user()->vendor_id);
        }
    }

    public function columns()
    {

        $columns = [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Active')->view('components.table.active'),
            Column::make('Multiple')->view('components.table.multiple'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.actions')
        ];

        //
        // if ($this->canManage) {
        //     array_push(
        //         $columns,
        //         Column::make('Actions')->view('components.buttons.actions')
        //     );
        // }
        return $columns;
    }
}
