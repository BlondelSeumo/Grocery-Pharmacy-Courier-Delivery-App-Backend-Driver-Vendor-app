<?php

namespace App\Http\Livewire;

use Exception;
use Illuminate\Support\Facades\DB;
use App\Models\Category;
use App\Models\Subcategory;

class SubCategoryLivewire extends BaseLivewireComponent
{

    //
    public $model = Subcategory::class;

    //
    public $name;
    public $category_id;
    public $isActive;

    protected $rules = [
        "name" => "required|string",
        "category_id" => "required|exists:categories,id",
    ];

    public function render()
    {

        return view('livewire.subcategories',[
            "categories" => Category::get(),
        ]);
    }

    public function showCreateModal()
    {
        $this->showCreate = true;
        $this->category_id = Category::get()->first()->id;
    }

    public function save(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = new Subcategory();
            $model->name = $this->name;
            $model->is_active = $this->isActive;
            $model->category_id = $this->category_id;
            $model->save();

            if( $this->photo ){

                $model->clearMediaCollection();
                $model->addMedia( $this->photo->getRealPath() )->toMediaCollection();
                $this->photo = null;

            }

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Subcategory created successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Subcategory creation failed!");

        }

    }

    public function initiateEdit($id){
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->isActive = $this->selectedModel->is_active;
        $this->category_id = $this->selectedModel->category_id;
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
            $model->category_id = $this->category_id;
            $model->save();

            if( $this->photo ){

                $model->clearMediaCollection();
                $model->addMedia( $this->photo->getRealPath() )->toMediaCollection();
                $this->photo = null;

            }

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Subcategory updated successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Subcategory updated failed!");

        }

    }



}
