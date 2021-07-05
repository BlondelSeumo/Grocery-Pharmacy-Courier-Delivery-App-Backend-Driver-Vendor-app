<?php

namespace App\Http\Livewire\Select;

use Asantibanez\LivewireSelect\LivewireSelect;
use Illuminate\Support\Collection;

class VendorMenuSelect extends LivewireSelect
{

    public function options($searchTerm = null): Collection
    {
        $carBrandId = $this->getDependingValue('car_brand_id');

        if ($this->hasDependency('car_brand_id') && $carBrandId != null) {
            return collect([
                ['value' => 'CRV', 'description' => 'Honda - CRV'],
                ['value' => 'Pilot', 'description' => 'Honda - Pilot'],
                ['value' => 'CX-3', 'description' => 'Mazda - CX-3'],
                ['value' => 'CX-5', 'description' => 'Mazda - CX-5'],
                ['value' => 'CX-9', 'description' => 'Mazda - CX-9'],
            ]);
        }

        return collect([
            ['value' => 'Model S', 'description' => 'Tesla - Model S'],
            ['value' => 'Model 3', 'description' => 'Tesla - Model 3'],
            ['value' => 'Model X', 'description' => 'Tesla - Model X'],
        ]);
    }
}
