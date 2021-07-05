<?php

namespace App\Http\Livewire;

use App\Models\Order;
use App\Traits\FirebaseMessagingTrait;
use Exception;
use Spatie\Permission\Models\Role;

class NotificationLivewire extends BaseLivewireComponent
{
    use FirebaseMessagingTrait;

    public $headings;
    public $message;
    public $roles;

    //
    public $allReceiver;
    public $customReceiver;
    public $customReceiverRoles;

    protected $rules = [
        "headings" => "required|string",
        "message" => "required|string",
    ];


    public function mount()
    {
        $this->allReceiver = true;
        $this->customReceiver = false;
        $this->customReceiverRoles = [];
    }

    public function render()
    {

        $this->roles = Role::all();
        return view('livewire.notification');
    }

    public function updatedAllReceiver()
    {
        $this->customReceiver = !$this->allReceiver;
    }
    public function updatedCustomReceiver()
    {
        $this->allReceiver = !$this->customReceiver;
    }



    public function sendNotification()
    {

        $this->validate();

        try {


            //fetching topic to send message to
            if ($this->customReceiver) {

                foreach ($this->customReceiverRoles as $topic) {
                    $this->sendFirebaseNotification($topic, $this->headings, $this->message, null);
                }
            } else {
                $this->sendFirebaseNotification("all", $this->headings, $this->message, null);
            }
            $this->showSuccessAlert("Notification sent successful");
            $this->reset();
            $this->mount();
        } catch (Exception $error) {
            $this->showErrorAlert($error->getMessage() ?? "Notification failed");
        }
    }
}
