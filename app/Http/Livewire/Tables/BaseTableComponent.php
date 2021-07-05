<?php

namespace App\Http\Livewire\Tables;

use Exception;
use Kdion4891\LaravelLivewireTables\TableComponent;
use Illuminate\Support\Facades\App;

class BaseTableComponent extends TableComponent
{

    public $canManage = true;

    protected $listeners = [
        'activateModel',
        'deactivateModel',
        'deleteModel',
        'refreshTable' => '$refresh',
    ];

    //
    public function thClass($attribute)
    {
        return 'p-2';
    }

    public function tdClass($attribute, $value)
    {
        return 'p-2';
    }

    public function trClass($model)
    {
        return 'border-b';
    }

    //Alert
    public function showSuccessAlert($message = "" ){
        $this->alert('success', "", [
            'position'  =>  'center',
            'text' => $message,
            'toast'  =>  false,
        ]);
    }

    public function showWarningAlert($message = "" ){
        $this->alert('warning', "", [
            'position'  =>  'center',
            'text' => $message,
            'toast'  =>  false,
        ]);
    }

    public function showErrorAlert($message = "" ){
        $this->alert('error', "", [
            'position'  =>  'center',
            'text' => $message,
            'toast'  =>  false,
        ]);
    }
    //End Alert



    public $selectedModel;
    public $model;

    public function initiateActivate($id){
        $this->selectedModel = $this->model::find($id);

        $this->confirm('Activate', [
            'toast' => false,
            'text' =>  'Are you sure you want to activate the selected data?',
            'position' => 'center',
            'showConfirmButton' => true,
            'cancelButtonText' => "Cancel",
            'onConfirmed' => 'activateModel',
            'onCancelled' => 'cancelled'
        ]);
    }

    public function initiateDeactivate($id){
        $this->selectedModel = $this->model::find($id);

        $this->confirm('Deactivate', [
            'toast' => false,
            'text' =>  'Are you sure you want to deactivate the selected data?',
            'position' => 'center',
            'showConfirmButton' => true,
            'cancelButtonText' => "Cancel",
            'onConfirmed' => 'deactivateModel',
            'onCancelled' => 'cancelled'
        ]);
    }

    public function initiateDelete($id){
        $this->selectedModel = $this->model::find($id);

        $this->confirm('Delete', [
            'toast' => false,
            'text' =>  'Are you sure you want to delete the selected data?',
            'position' => 'center',
            'showConfirmButton' => true,
            'cancelButtonText' => "Cancel",
            'onConfirmed' => 'deleteModel',
            'onCancelled' => 'cancelled'
        ]);
    }


    public function activateModel(){

        try{
            $this->selectedModel->is_active = true;
            $this->selectedModel->save();
            $this->showSuccessAlert("Activated");
        }catch(Exception $error){
            $this->showErrorAlert("Failed");
        }
    }


    public function deactivateModel(){

        try{
            $this->selectedModel->is_active = false;
            $this->selectedModel->save();
            $this->showSuccessAlert("Deactivated");
        }catch(Exception $error){
            $this->showErrorAlert("Failed");
        }
    }

    public function deleteModel(){

        try{
            $this->isDemo();
            $this->selectedModel->delete();
            $this->showSuccessAlert("Deleted");
        }catch(Exception $error){
            $this->showErrorAlert( $error->getMessage() ?? "Failed");
        }
    }




    public function isDemo()
    {
        if (!App::environment('production')) {
            throw new Exception("App is in demo version. Some changes can't be made");
        };
    }






}
