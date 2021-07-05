<?php

namespace App\Http\Livewire;

use Exception;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Storage;
use Spatie\Permission\Models\Role;

class BackUpLivewire extends BaseLivewireComponent
{

    protected $listeners = [
        'deleteModel',
        'refreshTable' => '$refresh',
    ];


    public function render()
    {

        $files = Storage::allFiles( env("APP_NAME") );
        return view('livewire.backup',[
            "backups" => $files,
        ]);
    }

    public function newBackUp(){

        try{

            Artisan::call("backup:run --only-db");
            $this->showSuccessAlert("Database backup successful");

        }catch(Exception $error){

            $this->showErrorAlert("Database backup failed");

        }

    }


    public function initiateDelete($file){

        $this->selectedModel = $file;
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


    public function deleteModel(){

        try{

            Storage::delete($this->selectedModel);
            $this->showSuccessAlert("Backup Deleted");

        }catch(Exception $error){
            $this->showErrorAlert( $error->getMessage() ?? "Backup delete Failed");
        }

    }


    public function downloadBackup($file)
    {
        return Storage::download($file);
    }



}
