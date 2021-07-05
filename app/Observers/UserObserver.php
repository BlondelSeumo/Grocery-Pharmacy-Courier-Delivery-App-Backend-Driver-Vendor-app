<?php

namespace App\Observers;

use App\Models\User;
use App\Mail\NewAccountMail;

class UserObserver
{

    public function creating(User $user)
    {
        //
        $user->code = \Str::random(3) . "" . $user->id . "" . \Str::random(2);
    }

    public function created(User $user)
    {
        //update wallet
        if (empty($user->wallet)) {
            $user->updateWallet(0);
        }
        //send mail
        try {
            \Mail::to($user->email)->send(new NewAccountMail($user));
        } catch (\Exception $ex) {
            logger("Mail Error", [$ex]);
        }
    }
}
