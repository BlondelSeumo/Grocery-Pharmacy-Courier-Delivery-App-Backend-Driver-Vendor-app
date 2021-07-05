<?php

namespace App\Http\Livewire;


use App\Models\Vendor;
use App\Models\Product;
use App\Models\User;
use App\Models\Coupon;
use Illuminate\Support\Facades\Auth;
use Exception;
use Illuminate\Support\Facades\DB;

class CouponLivewire extends BaseLivewireComponent
{

    //
    public $model = Coupon::class;

    //
    public $code;
    public $description;
    public $discount;
    public $percentage;
    public $expires_on;
    public $times;
    public $isActive = 1;

    //
    public $productsIDs;
    public $vendorsIDs;

    protected $rules = [
        "code" => "required|string",
        "discount" => "required|numeric",
        "expires_on" => "required|date",
    ];

    public function render()
    {

        return view('livewire.coupons', [
            "products" => $this->getProducts(),
            "vendors" => $this->getVendors(),
        ]);
    }

    public function getProducts()
    {

        $user = User::find(Auth::id());
        if ($user->hasRole('admin')) {
            return Product::active()->get();
        } elseif ($user->hasRole('city-admin')) {
            return Product::with('vendor')->whereHas("vendor", function ($query) {
                return $query->where('creator_id', Auth::id());
            });
        } else {
            return Product::active()->where('vendor_id', Auth::user()->vendor_id)->get();
        }
    }

    public function getVendors()
    {
        $user = User::find(Auth::id());
        if ($user->hasRole('admin')) {
            return Vendor::active()->get();
        } elseif ($user->hasRole('city-admin')) {
            return Vendor::active()->where('creator_id', Auth::id())->get();
        } else {
            return Vendor::active()->where('id', Auth::user()->vendor_id)->get();
        }
    }


    public function showCreateModal()
    {
        $this->showCreate = true;
        $this->showSelect2("#productsSelect2", $this->productsIDs, "productsChange");
        $this->showSelect2("#vendorsSelect2", $this->vendorsIDs, "vendorsChange");
    }


    public function save()
    {
        //validate
        $this->validate();

        try {

            DB::beginTransaction();
            $model = new Coupon();
            $model->code = $this->code;
            $model->description = $this->description;
            $model->discount = $this->discount;
            $model->percentage = $this->percentage ?? false;
            $model->expires_on = $this->expires_on;
            $model->times = $this->times;
            $model->is_active = $this->isActive;
            $model->creator_id = \Auth::id();
            $model->save();

            $model->products()->attach($this->productsIDs);
            $model->vendors()->attach($this->vendorsIDs);

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Coupon created successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Coupon creation failed!");
        }
    }

    // Updating model
    public function initiateEdit($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->code = $this->selectedModel->code;
        $this->description = $this->selectedModel->description;
        $this->discount = $this->selectedModel->discount;
        $this->percentage = $this->selectedModel->percentage;
        $this->expires_on = $this->selectedModel->expires_on;
        $this->times = $this->selectedModel->times;
        $this->isActive = $this->selectedModel->is_active;

        $this->productsIDs = $this->selectedModel->products()->pluck('id');
        $this->vendorsIDs = $this->selectedModel->vendors()->pluck('id');

        $this->showSelect2("#editProductsSelect2", $this->productsIDs, "productsChange");
        $this->showSelect2("#editVendorsSelect2", $this->vendorsIDs, "vendorsChange");

        $this->emit('showEditModal');
    }

    public function update()
    {
        //validate
        $this->validate();

        try {

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->code = $this->code;
            $model->description = $this->description;
            $model->discount = $this->discount;
            $model->percentage = $this->percentage;
            $model->expires_on = $this->expires_on;
            $model->times = $this->times;
            $model->is_active = $this->isActive;
            $model->save();

            $model->products()->sync($this->productsIDs);
            $model->vendors()->sync($this->vendorsIDs);

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Coupon updated successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Coupon updated failed!");
        }
    }



    public function productsChange($data)
    {
        $this->productsIDs = $data;
    }

    public function vendorsChange($data)
    {
        $this->vendorsIDs = $data;
    }
}
