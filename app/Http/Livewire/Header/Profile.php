<?php

namespace App\Http\Livewire\Header;

use App\Models\UserToken;
use Livewire\Component;
use Illuminate\Support\Facades\Auth;

class Profile extends Component
{
    protected $listeners = [
        'logout' => 'logout',
        'changeFCMToken' => 'changeFCMToken',
    ];

    public function render()
    {
        return view('livewire.header.profile');
    }


    public function logout(){
        UserToken::where('token', $this->fcmToken)->delete();
        return redirect()->route('logout');
    }
   
    public $fcmToken;
    public function changeFCMToken($token)
    {
        $this->fcmToken = $token;
        if (Auth::check() && !empty($this->fcmToken)) {
            //
            UserToken::updateOrCreate(
                ['token' => $this->fcmToken],
                ['user_id' => Auth::id()]
            );
        }
    }

}
