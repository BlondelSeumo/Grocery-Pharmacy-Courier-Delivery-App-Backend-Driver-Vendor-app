<?php

namespace App\Http\Livewire;

use App\Models\OptionGroup;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class OptionGroupLivewire extends BaseLivewireComponent
{

    //
    public $model = OptionGroup::class;

    //
    public $name;
    public $multiple = 1;
    public $isActive = 1;

    protected $rules = [
        "name" => "required|string",
    ];

    public function render()
    {
        return view('livewire.options-group');
    }



    public function save(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = new OptionGroup();
            $model->name = $this->name;
            $model->multiple = $this->multiple;
            $model->is_active = $this->isActive;
            $model->vendor_id = Auth::user()->vendor_id;
            $model->save();
            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Option Group created successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Option Group creation failed!");

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
            $model->multiple = $this->multiple;
            $model->is_active = $this->isActive;
            $model->save();
            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Option Group updated successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Option Group updated failed!");

        }

    }



}
