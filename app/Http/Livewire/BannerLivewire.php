<?php

namespace App\Http\Livewire;

use App\Models\Banner;
use App\Models\Category;
use Exception;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;

class BannerLivewire extends BaseLivewireComponent
{

    //
    public $model = Banner::class;

    //
    public $category_id;
    public $isActive;

    protected $rules = [
        "category_id" => "required|exists:categories,id",
        "photo" => "required|image|max:4096",
    ];


    protected $messages = [
        "photo.max" => "Photo must be less than 4MB"
    ];

    public function render()
    {
        return view('livewire.banners',[
            "categories" => Category::active()->get(),
        ]);
    }

    public function showCreateModal(){
        $this->showCreate = true;
        $this->category_id = Category::active()->first()->id ?? null;
    }

    public function save(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = new Banner();
            $model->category_id = $this->category_id;
            $model->is_active = $this->isActive;
            $model->save();

            if( $this->photo ){

                $model->clearMediaCollection();
                $model->addMedia( $this->photo->getRealPath() )->toMediaCollection();
                $this->photo = null;

            }

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Banner created successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Banner creation failed!");

        }

    }

    public function initiateEdit($id){
        $this->selectedModel = $this->model::find($id);
        $this->category_id = $this->selectedModel->category_id;
        $this->isActive = $this->selectedModel->is_active;
        $this->emit('showEditModal');
    }

    public function update(){
        //validate
        $this->validate(
            [
                "category_id" => "required|exists:categories,id",
                "photo" => "sometimes|nullable|image|max:4096",
            ]
        );

        try{

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->category_id = $this->category_id;
            $model->is_active = $this->isActive;
            $model->save();

            if( $this->photo ){

                $model->clearMediaCollection();
                $model->addMedia( $this->photo->getRealPath() )->toMediaCollection();
                $this->photo = null;

            }

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Banner updated successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Banner updated failed!");

        }

    }



}
