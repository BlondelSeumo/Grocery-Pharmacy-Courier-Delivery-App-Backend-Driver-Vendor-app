<?php

namespace App\Http\Livewire\Select;

use Asantibanez\LivewireSelect\LivewireSelect;
use Illuminate\Support\Collection;

class VendorSelect extends LivewireSelect
{

    public function options($searchTerm = null): Collection
    {
        return collect([
            [
                'value' => '1',
                'description' => 'Honda',
            ],
            [
                'value' => '2',
                'description' => 'Mazda',
            ],
            [
                'value' => '3',
                'description' => 'Tesla',
            ],
        ]);
    }
}
