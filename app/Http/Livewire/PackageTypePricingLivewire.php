<?php

namespace App\Http\Livewire;

use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\PackageType;
use App\Models\User;
use App\Models\PackageTypePricing;

class PackageTypePricingLivewire extends BaseLivewireComponent
{

    //
    public $model = PackageTypePricing::class;

    //
    public $package_type_id;
    public $max_booking_days;
    public $base_price;
    public $size_price;
    public $price_per_kg;
    public $distance_price;
    public $price_per_km;
    public $auto_assignment;
    public $field_required;
    public $is_active;

    protected $rules = [
        "package_type_id" => "required|exists:package_types,id",
        "max_booking_days" => "required|numeric",
        "size_price" => "required|numeric",
        "distance_price" => "required|numeric",
    ];


    public function render()
    {

        $packageTypes = PackageType::active()->get();
        if( empty($this->package_type_id) ){
            $this->package_type_id = $packageTypes->first()->id;
        }

        return view('livewire.package_types_pricing',[
            "packageTypes" => $packageTypes,
        ]);
    }

    public function save(){

        //validate
        $this->validate();


        try{

            //vendor
            $vendor = User::where('id', Auth::id())->first()->vendor;
            DB::beginTransaction();
            $model = new PackageTypePricing();
            $model->vendor_id = $vendor->id;
            $model->package_type_id = $this->package_type_id;
            $model->max_booking_days = $this->max_booking_days ?? 7;
            $model->base_price = $this->base_price ?? 0.00;
            $model->size_price = $this->size_price;
            $model->price_per_kg = $this->price_per_kg ?? 0;
            $model->distance_price = $this->distance_price;
            $model->price_per_km = $this->price_per_km ?? 0;
            $model->auto_assignment = $this->auto_assignment ?? 0;
            $model->field_required = $this->field_required ?? 0;
            $model->is_active = $this->is_active ?? 0;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Package Type Pricing created successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Package Type Pricing creation failed!");
        }

    }

    public function initiateEdit($id){
        $this->selectedModel = $this->model::find($id);
        $this->package_type_id = $this->selectedModel->package_type_id;
        $this->max_booking_days = $this->selectedModel->max_booking_days;
        $this->base_price = $this->selectedModel->base_price;
        $this->size_price = $this->selectedModel->size_price;
        $this->price_per_kg = $this->selectedModel->price_per_kg;
        $this->distance_price = $this->selectedModel->distance_price;
        $this->price_per_km = $this->selectedModel->price_per_km;
        $this->auto_assignment = $this->selectedModel->auto_assignment;
        $this->field_required = $this->selectedModel->field_required;
        $this->is_active = $this->selectedModel->is_active;
        $this->emit('showEditModal');
    }

    public function update(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->package_type_id = $this->package_type_id;
            $model->max_booking_days = $this->max_booking_days ?? 7;
            $model->base_price = $this->base_price;
            $model->size_price = $this->size_price;
            $model->price_per_kg = $this->price_per_kg ?? 0;
            $model->distance_price = $this->distance_price;
            $model->price_per_km = $this->price_per_km ?? 0;
            $model->auto_assignment = $this->auto_assignment ?? 0;
            $model->field_required = $this->field_required ?? 0;
            $model->is_active = $this->is_active ?? 0;
            $model->save();

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Package Type Pricing updated successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Package Type Pricing updated failed!");

        }

    }



}
