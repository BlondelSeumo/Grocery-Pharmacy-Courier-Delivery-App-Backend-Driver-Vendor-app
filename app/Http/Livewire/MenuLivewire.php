<?php

namespace App\Http\Livewire;

use App\Models\Menu;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class MenuLivewire extends BaseLivewireComponent
{

    //
    public $model = Menu::class;

    //
    public $name;
    public $isActive = 1;

    protected $rules = [
        "name" => "required|string",
    ];

    public function render()
    {
        return view('livewire.menu');
    }



    public function save(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = new Menu();
            $model->name = $this->name;
            $model->is_active = $this->isActive;
            $model->vendor_id = Auth::user()->vendor_id;
            $model->save();
            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Menu created successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Menu creation failed!");

        }

    }

    // Updating model
    public function initiateEdit($id){
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->isActive = $this->selectedModel->is_active;
        $this->emit('showEditModal');
    }

    public function update(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->name = $this->name;
            $model->is_active = $this->isActive;
            $model->save();
            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Menu updated successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Menu updated failed!");

        }

    }



}
