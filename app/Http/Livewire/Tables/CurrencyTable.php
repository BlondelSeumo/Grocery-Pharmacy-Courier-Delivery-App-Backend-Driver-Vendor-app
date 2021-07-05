<?php

namespace App\Http\Livewire\Tables;

use App\Models\Currency;
use Kdion4891\LaravelLivewireTables\Column;

class CurrencyTable extends BaseTableComponent
{

    public $model = Currency::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {
        return Currency::query();
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Name')->searchable(),
            Column::make('Code')->searchable(),
            Column::make('Country Code')->searchable(),
            Column::make('Symbol')->searchable(),
            Column::make('Actions')->view('components.buttons.currency_actions'),
        ];
    }

    public function activateModel()
    {

        try {

            // update the site name
            setting([
                'currencyCode' =>  $this->selectedModel->code,
                'currency' =>  $this->selectedModel->symbol,
                'currencyCountryCode' =>  $this->selectedModel->country_code ?? 'GH',
            ])->save();
            $this->showSuccessAlert("Activated");
        } catch (Exception $error) {
            $this->showErrorAlert("Failed");
        }
    }
}
