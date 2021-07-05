<?php

namespace App\Http\Livewire\Auth;

use Livewire\Component;

class PasswordResetLivewire extends Component
{
    public function render()
    {
        return view('livewire.auth.password-')->layout('layouts.auth');
    }
}
