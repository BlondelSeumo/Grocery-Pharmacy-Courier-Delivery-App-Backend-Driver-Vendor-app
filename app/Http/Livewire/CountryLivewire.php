<?php

namespace App\Http\Livewire;

use App\Models\Country;
use Exception;
use Illuminate\Support\Facades\DB;

class CountryLivewire extends BaseLivewireComponent
{

    //
    public $model = Country::class;

    //
    public $name;

    protected $rules = [
        "name" => "required|string",
    ];


    public function render()
    {
        return view('livewire.countries');
    }

    public function save(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = new Country();
            $model->name = $this->name;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Country created successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Country creation failed!");

        }

    }

    public function initiateEdit($id){
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->emit('showEditModal');
    }

    public function update(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->name = $this->name;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Country updated successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Country updated failed!");

        }

    }




}
