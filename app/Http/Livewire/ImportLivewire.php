<?php

namespace App\Http\Livewire;

use App\Imports\CategoriesImport;
use App\Imports\VendorsImport;
use App\Imports\MenusImport;
use App\Imports\ProductsImport;
use Maatwebsite\Excel\Facades\Excel;

class ImportLivewire extends BaseLivewireComponent
{


    public $dataType;
    public $dataTypeName;
    public $photo;

    protected $rules = [
        "photo" => "required"
    ];

    protected $messages = [
        "photo.required" => "Please select data file to import"
    ];

    public function render()
    {
        return view('livewire.imports');
    }


    public function showImportDialog($dataType, $dataTypeName)
    {

        $this->dataType = $dataType;
        $this->dataTypeName = $dataTypeName;
        $this->showCreateModal();
    }

    public function processImport()
    {
        //
        $this->validate();


        $uploadedFile = $this->photo->store('imports/excel');

        try {

            $this->isDemo();

            switch ($this->dataType) {
                case 1:
                    Excel::import(new CategoriesImport, $uploadedFile);
                    break;
                case 2:
                    Excel::import(new VendorsImport, $uploadedFile);
                    break;
                case 3:
                    Excel::import(new MenusImport, $uploadedFile);
                    break;
                case 4:
                    Excel::import(new ProductsImport, $uploadedFile);
                    break;

                default:
                    # code...
                    break;
            }
            //

            $this->showSuccessAlert("Data imported successfully!");

            //delete file after import
            \Storage::delete($uploadedFile);
            $this->reset();
            $this->showCreate = false;

        } catch (\Exception $error) {
            $this->showErrorAlert($error->getMessage() ?? "Data import failed!");
        }
    }
}
