<?php

namespace App\Http\Livewire;

use App\Models\CountryVendor;
use App\Models\Country;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class VendorCountriesLivewire extends BaseLivewireComponent
{

    //
    public $model = CountryVendor::class;

    //
    public $name;
    public $country_id;
    public $isActive;
    public $countries;
    public $states;
    public $cities;

    protected $rules = [
        "country_id" => "required",
    ];



    public function mount(){
        $this->refreshForm();
    }

    public function refreshForm(){
        $this->countries = Country::get();
        //
        $this->country_id = $this->countries->first()->id;
    }

    public function render()
    {

        return view('livewire.vendor_countries');
    }

    public function showCreateModal(){
        $this->showCreate = true;
        $this->refreshForm();
    }


    public function countryChanged(){
        
    }

    public function prepareNewFormData()
    {
        
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
            $model = new CountryVendor();
            $model->country_id = $this->country_id;
            $model->vendor_id = Auth::user()->vendor_id;
            $model->is_active = $this->isActive ?? 0;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->refreshForm();
            $this->showSuccessAlert("Country assigned successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Country assignment failed!");
        }
    }

    public function initiateEdit($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->isActive = $this->selectedModel->is_active;
        $this->country_id = $this->selectedModel->country_id;
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
            $model->country_id = $this->country_id;
            $model->is_active = $this->isActive ?? 0;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->refreshForm();
            $this->showSuccessAlert("Country updated successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Country updated failed!");
        }
    }
}
