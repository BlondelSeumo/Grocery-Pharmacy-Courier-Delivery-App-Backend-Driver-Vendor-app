<?php

namespace App\Http\Livewire;

use App\Models\Meeting;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Exception;
use Illuminate\Support\Facades\Hash;

class ProfileLivewire extends BaseLivewireComponent
{

    public $model = Meeting::class;

    //
    public $name;
    public $email;
    public $phone;

    public $current_password;
    public $new_password;
    public $new_password_confirmation;

    public function render()
    {

        $user = User::find( Auth::id() );
        $this->name = $user->name;
        $this->email = $user->email;
        $this->phone = $user->phone;

        return view('livewire.profile');
    }


    // Update profile
    public function updateProfile(){
        //validate
        $this->validate(
            [
                "name" => "required|string",
                "email" => "required|email|unique:users,email,".Auth::id()."",
                'phone' => 'phone:' . setting('countryCode', "GH") . '|unique:users,phone,'.Auth::id(),
            ]
        );

        try{

            DB::beginTransaction();
            $user = User::find( Auth::id() );
            $user->name = $this->name;
            $user->email = $this->email;
            $user->phone = $this->phone;
            $user->save();

            if( $this->photo ){

                $user->clearMediaCollection("profile");
                $user->addMedia( $this->photo->getRealPath() )->toMediaCollection("profile");
                $this->photo = null;

            }

            DB::commit();
            $this->showSuccessAlert("Profile Updated successfully!");

        }catch(Exception $error){

            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Profile Updated failed!");

        }

    }


    // Change Password
    public function changePassword(){
        //validate
        $this->validate(
            [
                "current_password" => "required|string",
                "new_password" => "required|confirmed|min:6",
            ]
        );

        try{

            if( !Hash::check( $this->current_password , Auth::user()->password ) ){
                throw new Exception("Currenct Password is incorrect");
            }

            $user = User::find( Auth::id() );
            $user->password = Hash::make($this->new_password );
            $user->save();
            $this->reset();
            $this->showSuccessAlert("Password Updated successfully!");

        }catch(Exception $error){

            DB::rollback();
            $this->showErrorAlert( $error->getMessage() ?? "Password Updated failed!");

        }

    }


}
