<?php

namespace App\Http\Livewire;

use App\Models\UserToken;
use Livewire\Component;
use Livewire\WithPagination;
use Livewire\WithFileUploads;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Auth;
use Exception;

class BaseLivewireComponent extends Component
{
    use WithPagination, WithFileUploads;

    public $perPage = 6;
    public $showPassword = false;
    public $model;
    public $selectedModel;
    public $photoInfo;
    public $secondPhotoInfo;
    public $photo;
    public $secondPhoto;

    protected $listeners = [
        'showCreateModal' => 'showCreateModal',
        'showEditModal' => 'showEditModal',
        'showDetailsModal' => 'showDetailsModal',
        'showAssignModal' => 'showAssignModal',
        'initiateEdit' => 'initiateEdit',
        'initiateDelete' => 'initiateDelete',
        'initiateAssign' => 'initiateAssign',
        'initiateSubcategoriesAssign' => 'initiateSubcategoriesAssign',
        'initiatePayout' => 'initiatePayout',
        'dismissModal' => 'dismissModal',
        'refreshView' => '$refresh',
        'select2Change' => 'select2Change',
        'productsChange' => 'productsChange',
        'vendorsChange' => 'vendorsChange',
        'managersChange' => 'managersChange',
        'paymentMethodsChange' => 'paymentMethodsChange',
        'categoriesChange' => 'categoriesChange',
        'vendorChange' => 'vendorChange',
        'changeVendorTiming' => 'changeVendorTiming',
        'changeFCMToken' => 'changeFCMToken',
        'logout' => 'logout',
        'reviewPayment' => 'reviewPayment',
    ];

    public function togglePassword()
    {
        $this->showPassword = !$this->showPassword;
    }

    //Alert
    public function showSuccessAlert($message = "")
    {
        $this->alert('success', "", [
            'position'  =>  'center',
            'text' => $message,
            'toast'  =>  false,
        ]);
    }

    public function showWarningAlert($message = "")
    {
        $this->alert('warning', "", [
            'position'  =>  'center',
            'text' => $message,
            'toast'  =>  false,
        ]);
    }

    public function showErrorAlert($message = "")
    {
        $this->alert('error', "", [
            'position'  =>  'center',
            'text' => $message,
            'toast'  =>  false,
        ]);
    }

    public function showSelect2($selectorID, $data, $onChange)
    {
        $this->emit('showSelect2', [
            $selectorID,
            $data,
            $onChange
        ],);
    }


    // Modal management
    public $showCreate = false;
    public $showEdit = false;
    public $showDetails = false;
    public $showAssign = false;
    public function showCreateModal()
    {
        $this->showCreate = true;
    }

    public function showEditModal()
    {
        $this->showEdit = true;
    }

    public function showDetailsModal($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->showDetails = true;
    }

    public function showAssignModal()
    {
        $this->showAssign = true;
    }





    public function dismissModal()
    {
        $this->showCreate = false;
        $this->showEdit = false;
        $this->reset();
    }


    //
    public function updatedPhoto()
    {

        $file = array();

        if ($this->photo != null) {
            $filePath = pathinfo($this->photo->getRealPath());
            $file['name'] = $filePath['filename'];
            $file['extension'] = $filePath['extension'];
            //convert size to MB
            $file['size'] = number_format(filesize($filePath['dirname'] . '/' . $filePath['basename']) * 0.000001, 2);
        }

        $this->photoInfo = $file;
    }

    public function updatedSecondPhoto()
    {

        $file = array();

        if ($this->secondPhoto != null) {
            $filePath = pathinfo($this->secondPhoto->getRealPath());
            $file['name'] = $filePath['filename'];
            $file['extension'] = $filePath['extension'];
            //convert size to MB
            $file['size'] = number_format(filesize($filePath['dirname'] . '/' . $filePath['basename']) * 0.000001, 2);
        }

        $this->secondPhotoInfo = $file;
    }







    //
    public function orderStatus()
    {
        return ['scheduled', 'pending', 'preparing', 'ready', 'enroute', 'failed', 'cancelled', 'delivered'];
    }

    public function orderPaymentStatus()
    {
        return ['pending', 'review', 'failed', 'cancelled', 'successful'];
    }



    //
    public function isDemo()
    {
        if (!App::environment('production')) {
            throw new Exception("App is in demo version. Some changes can't be made");
        };
    }





    //FCM
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


    public function logout()
    {
        UserToken::where('token', $this->fcmToken)->delete();
        return redirect()->route('logout');
    }
}
