<?php

namespace App\Http\Livewire;

class PayoutLivewire extends BaseLivewireComponent
{


    public $type;
    protected $queryString = ['type'];

    public function mount()
    {
        if ($this->type != "drivers" && !\Auth::user()->hasAnyRole('admin','city-admin')) {
            return redirect()->route('dashboard');
        }
    }

    public function render()
    {
        return view('livewire.payouts');
    }
}
