<?php

namespace App\Http\Livewire;

use App\Models\User;
use Exception;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;

class UserLivewire extends BaseLivewireComponent
{

    //
    public $model = User::class;

    //
    public $name;
    public $email;
    public $phone;
    public $password;
    public $role;
    public $commission;
    public $walletBalance;

    protected $rules = [
        "name" => "required|string",
        "email" => "required|email|unique:users",
        "phone" => "required|unique:users",
        "password" => "sometimes|nullable|string",
        "commission" => "sometimes|nullable|numeric",
        "walletBalance" => "sometimes|nullable|numeric",
    ];


    protected $messages = [
        "email.unique" => "Email already associated with any account",
        "phone.unique" => "Phone Number already associated with any account",
    ];

    public function render()
    {

        
        return view('livewire.users', [
            "roles" => $this->getRoles(),
        ]);
    }

    public function getRoles(){
        $user = User::find(\Auth::id());
        $roles = [];
        if ($user->hasRole('admin')) {
            $roles = Role::all();
        } else {
            $roles = Role::where('name','not like', '%admin%')->get();
        }
        return $roles;
    }

    public function showCreateModal()
    {
        $this->reset();
        $this->role = $this->getRoles()->first->name;
        $this->showCreate = true;
    }

    public function save()
    {
        //validate
        $this->validate();

        try {

            DB::beginTransaction();
            $user = new User();
            $user->name = $this->name;
            $user->email = $this->email;
            $user->phone = $this->phone;
            $user->creator_id = \Auth::id();
            $user->commission = $this->commission ?? 0.00;
            $user->password = Hash::make($this->password);
            $user->save();

            if (!empty($this->role)) {
                $user->assignRole($this->role);
            }

            //update wallet
            $user->updateWallet($this->walletBalance);

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("User created successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "User creation failed!");
        }
    }

    public function initiateEdit($id)
    {
        $this->reset();
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->email = $this->selectedModel->email;
        $this->phone = $this->selectedModel->phone;
        $this->role = $this->selectedModel->role_id;
        $this->commission = $this->selectedModel->commission;
        $this->walletBalance = $this->selectedModel->wallet->balance ?? 0.00;
        $this->emit('showEditModal');
    }

    public function update()
    {
        //validate
        $this->validate(
            [
                "name" => "required|string",
                "email" => "required|email|unique:users,email," . $this->selectedModel->id . "",
                "phone" => "required|unique:users,phone," . $this->selectedModel->id . "",
                "password" => "sometimes|nullable|string",
                "commission" => "sometimes|nullable|numeric",
                "walletBalance" => "sometimes|nullable|numeric",
            ]
        );

        try {

            DB::beginTransaction();
            $user = $this->selectedModel;
            $user->name = $this->name;
            $user->email = $this->email;
            $user->phone = $this->phone;
            $user->commission = $this->commission ?? 0.00;
            if (!empty($this->password)) {
                $user->password = Hash::make($this->password);
            }
            $user->save();

            if (!empty($this->role)) {
                $user->syncRoles($this->role);
            }


            //update wallet
            $user->updateWallet($this->walletBalance);

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("User created successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "User creation failed!");
        }
    }
}
