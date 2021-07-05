<?php

namespace App\Http\Livewire;

use App\Models\City;
use App\Models\State;
use App\Models\Country;
use Exception;
use Illuminate\Support\Facades\DB;

class CitiesLivewire extends BaseLivewireComponent
{

    //
    public $model = City::class;

    //
    public $name;
    public $country_id;
    public $state_id;

    protected $rules = [
        "name" => "required|string",
        "state_id" => "required|exists:states,id",
    ];


    public function render()
    {

        //
        $countries = Country::get();

        //
        if( $this->country_id != null ){
            $states = State::where('country_id', $this->country_id )->get();
        }else{
            $states = State::where('country_id', $countries->first()->id )->get();
        }

        return view('livewire.cities',[
            "countries" => $countries,
            "states" => $states,
        ]);
    }

    public function save(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = new City();
            $model->name = $this->name;
            $model->state_id = $this->state_id;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("City created successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "City creation failed!");

        }

    }

    public function initiateEdit($id){
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->state_id = $this->selectedModel->state_id;
        $this->country_id = $this->selectedModel->state->country->id;
        $this->emit('showEditModal');
    }

    public function update(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->name = $this->name;
            $model->state_id = $this->state_id;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("City updated successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "City updated failed!");

        }

    }



}
