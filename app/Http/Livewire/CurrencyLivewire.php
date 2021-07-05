<?php

namespace App\Http\Livewire;

use App\Models\Currency;
use Illuminate\Support\Facades\DB;
use Exception;

class CurrencyLivewire extends BaseLivewireComponent
{

    //
    public $model = Currency::class;
    public $name;
    public $code;
    public $country_code;
    public $symbol;

    public function render()
    {
        return view('livewire.settings.currency');
    }

    public function initiateEdit($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->code = $this->selectedModel->code;
        $this->country_code = $this->selectedModel->country_code;
        $this->symbol = $this->selectedModel->symbol;
        $this->emit('showEditModal');
    }

    public function save()
    {
        //validate
        $this->validate(
            [
                "name" => "required|string",
                "symbol" => "required|string",
                "country_code" => "required|string",
                "code" => "required|string|unique:currencies",
            ]
        );

        try {

            DB::beginTransaction();
            $this->selectedModel = new Currency();
            $this->selectedModel->name = $this->name;
            $this->selectedModel->code = $this->code;
            $this->selectedModel->symbol = $this->symbol;
            $this->selectedModel->country_code = $this->country_code;
            $this->selectedModel->save();
            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Currency saved successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Currency saved failed!");
        }
    }

    public function update()
    {
        //validate
        $this->validate(
            [
                "name" => "required|string",
                "symbol" => "required|string",
                "country_code" => "required|string",
                "code" => "required|string|unique:currencies,code,".$this->selectedModel->id."",
            ]
        );

        try {

            DB::beginTransaction();
            $this->selectedModel->name = $this->name;
            $this->selectedModel->code = $this->code;
            $this->selectedModel->country_code = $this->country_code;
            $this->selectedModel->symbol = $this->symbol;
            $this->selectedModel->save();
            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Currency updated successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Currency updated failed!");
        }
    }
}
