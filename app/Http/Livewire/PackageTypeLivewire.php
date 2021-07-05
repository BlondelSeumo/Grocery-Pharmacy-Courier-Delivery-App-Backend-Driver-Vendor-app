<?php

namespace App\Http\Livewire;

use Exception;
use Illuminate\Support\Facades\DB;
use App\Models\PackageType;

class PackageTypeLivewire extends BaseLivewireComponent
{

    //
    public $model = PackageType::class;

    //
    public $name;
    public $description;
    public $is_active;

    protected $rules = [
        "name" => "required|string",
    ];


    public function render()
    {
        return view('livewire.package_types');
    }

    public function save(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = new PackageType();
            $model->name = $this->name;
            $model->description = $this->description;
            $model->is_active = $this->is_active ?? 0;
            $model->save();

            if( $this->photo ){

                $model->clearMediaCollection();
                $model->addMedia( $this->photo->getRealPath() )->toMediaCollection();
                $this->photo = null;

            }

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Package Type created successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Package Type creation failed!");
        }

    }

    public function initiateEdit($id){
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->description = $this->selectedModel->description;
        $this->is_active = $this->selectedModel->is_active;
        $this->emit('showEditModal');
    }

    public function update(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->name = $this->name;
            $model->description = $this->description;
            $model->is_active = $this->is_active ?? 0;
            $model->save();

            if( $this->photo ){

                $model->clearMediaCollection();
                $model->addMedia( $this->photo->getRealPath() )->toMediaCollection();
                $this->photo = null;

            }

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Package Type updated successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Package Type updated failed!");

        }

    }



}
