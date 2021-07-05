<?php

namespace App\Http\Livewire\Tables;

use App\Models\Vendor;
use Kdion4891\LaravelLivewireTables\Column;
use Illuminate\Support\Facades\Auth;

class VendorTable extends BaseTableComponent
{

    public $model = Vendor::class;
    public $header_view = 'components.buttons.new';

    public function mount(){

        //
        if( Auth::user()->hasRole('manager') ){
            $this->header_view = null;
            $this->canManage = false;
        }
        //
        $this->setTableProperties();
    }

    public function query()
    {
        return Vendor::mine();
    }

    public function columns()
    {

        $this->mount();
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Logo')->view('components.table.logo'),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Address')->searchable(),
            Column::make('Type'),
            Column::make('Active')->view('components.table.active'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.market_actions'),
        ];
    }

    //
    public function deleteModel(){

        try{
            $this->isDemo();
            \DB::beginTransaction();
            $this->selectedModel->delete();
            \DB::commit();
            $this->showSuccessAlert("Deleted");
        }catch(Exception $error){
            \DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Failed");
        }
    }

}
