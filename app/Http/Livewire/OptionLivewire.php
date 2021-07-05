<?php

namespace App\Http\Livewire;

use App\Models\Option;
use App\Models\OptionGroup;
use App\Models\Product;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Exception;
use Illuminate\Support\Facades\DB;

class OptionLivewire extends BaseLivewireComponent
{

    //
    public $model = Option::class;

    //
    public $name;
    public $description;
    public $price;
    public $product_id;
    public $option_group_id;
    public $isActive = 1;


    protected $rules = [
        "name" => "required|string",
        "product_id" => "required|exists:products,id",
        "option_group_id" => "required|exists:option_groups,id",
        "photo" => "sometimes|nullable|image|max:1024",
    ];

    public function render()
    {

        return view('livewire.options',[
            "products" => $this->getProducts(),
            "optionGroups" => $this->getOptionGroup(),
        ]);
    }

    public function getProducts(){
        if( User::find( Auth::id() )->hasRole('admin') ){
            return Product::active()->get();
        }else{
            return Product::active()->where('vendor_id', Auth::user()->vendor_id )->get();
        }
    }

    public function getOptionGroup(){
        if( User::find( Auth::id() )->hasRole('admin') ){
            return OptionGroup::active()->get();
        }else{
            return OptionGroup::active()->where('vendor_id', Auth::user()->vendor_id )->get();
        }
    }


    public function showCreateModal(){
        $this->showCreate = true;
        $this->option_group_id = $this->getOptionGroup()->first()->id ?? null;
        $this->product_id = $this->getProducts()->first()->id ?? null;
    }

    public function save(){
        //validate
        $this->validate();

        try{

            DB::beginTransaction();
            $model = new Option();
            $model->name = $this->name;
            $model->description = $this->description;
            $model->price = $this->price ?? 0;
            $model->product_id = $this->product_id;
            $model->option_group_id = $this->option_group_id;
            $model->is_active = $this->isActive;
            $model->vendor_id = Auth::user()->vendor_id;
            $model->save();

            if( $this->photo ){

                $model->clearMediaCollection();
                $model->addMedia( $this->photo->getRealPath() )->toMediaCollection();
                $this->photo = null;

            }

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Option created successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Option creation failed!");

        }

    }

    // Updating model
    public function initiateEdit($id){
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->description = $this->selectedModel->description;
        $this->price = $this->selectedModel->price;
        $this->isActive = $this->selectedModel->is_active;
        $this->product_id = $this->selectedModel->product_id;
        $this->option_group_id = $this->selectedModel->option_group_id;
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
            $model->price = $this->price ?? 0;
            $model->product_id = $this->product_id;
            $model->option_group_id = $this->option_group_id;
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
            $this->showSuccessAlert("Option updated successfully!");
            $this->emit('refreshTable');


        }catch(Exception $error){
            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Option updated failed!");

        }

    }



}
