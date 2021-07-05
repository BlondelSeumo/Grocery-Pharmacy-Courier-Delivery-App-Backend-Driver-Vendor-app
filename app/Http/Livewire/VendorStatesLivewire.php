<?php

namespace App\Http\Livewire;

use App\Models\City;
use App\Models\State;
use App\Models\Country;
use App\Models\StateVendor;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class VendorStatesLivewire extends BaseLivewireComponent
{

    //
    public $model = StateVendor::class;

    //
    public $name;
    public $country_id;
    public $state_id;
    public $city_id;
    public $isActive;
    public $countries;
    public $states;
    public $cities;

    protected $rules = [
        "state_id" => "required",
    ];



    public function mount(){
        $this->refreshForm();
    }

    public function refreshForm(){
        $this->countries = Country::get();
        //
        $this->country_id = $this->countries->first()->id;
        $this->states = State::where('country_id', $this->country_id)->get();
        //
        $this->state_id = $this->states->first()->id;
    }

    public function render()
    {

        return view('livewire.vendor_states');
    }

    public function showCreateModal(){
        $this->showCreate = true;
        $this->refreshForm();
    }


    public function countryChanged()
    {
        $this->states = State::where('country_id', $this->country_id)->get();
        //
        $this->state_id = $this->states->first()->id;
        $this->stateChanged();
    }

    public function stateChanged()
    {
        $this->cities = City::where('state_id', $this->state_id)->get();
        //
        $this->city_id = $this->cities->first()->id ?? null;
    }


    public function prepareNewFormData()
    {
        $this->states = State::where('country_id', $this->country_id)->get();
        //
        $this->cities = City::where('state_id', $this->state_id)->get();
    }

    public function dismissModal(){
        $this->showCreate = false;
        $this->showEdit = false;
    }


    public function save()
    {
        //validate
        $this->validate();

        try {

            DB::beginTransaction();
            $model = new StateVendor();
            $model->state_id = $this->state_id;
            $model->vendor_id = Auth::user()->vendor_id;
            $model->is_active = $this->isActive ?? 0;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->refreshForm();
            $this->showSuccessAlert("State assigned successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "State assignment failed!");
        }
    }

    public function initiateEdit($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->isActive = $this->selectedModel->is_active;
        $this->state_id = $this->selectedModel->state_id;
        $this->country_id = $this->selectedModel->state->country_id;
        $this->prepareNewFormData();
        $this->emit('showEditModal');
    }

    public function update()
    {
        //validate
        $this->validate();

        try {

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->state_id = $this->state_id;
            $model->is_active = $this->isActive ?? 0;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->refreshForm();
            $this->showSuccessAlert("State updated successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "State updated failed!");
        }
    }
}
