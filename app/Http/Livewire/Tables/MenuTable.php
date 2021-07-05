<?php

namespace App\Http\Livewire\Tables;

use App\Models\Menu;
use Kdion4891\LaravelLivewireTables\Column;
use Illuminate\Support\Facades\Auth;

class MenuTable extends BaseTableComponent
{

    public $model = Menu::class;
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
        if (Auth::user()->hasRole('manager')) {
            return Menu::where('vendor_id', Auth::user()->vendor_id );
        } else {
            return Menu::query();
        }
    }

    public function columns()
    {

        $columns = [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Active')->view('components.table.active'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.actions')
        ];
        return $columns;
    }
}
