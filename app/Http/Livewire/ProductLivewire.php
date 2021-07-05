<?php

namespace App\Http\Livewire;

use App\Models\Menu;
use App\Models\Vendor;
use App\Models\Product;
use App\Models\Category;
use App\Models\Subcategory;
use App\Models\User;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class ProductLivewire extends BaseLivewireComponent
{

    //
    public $model = Product::class;

    //
    public $name;
    public $description;
    public $price;
    public $discount_price = 0;
    public $capacity;
    public $unit;
    public $package_count;
    public $available_qty;
    public $vendorID;
    public $featured;
    public $deliverable = 1;
    public $isActive = 1;

    //
    public $menusIDs = [];
    public $categoriesIDs;
    public $subCategoriesIDs = [];

    //
    public $showAssignSubcategories = false;
    public $subCategories = [];


    protected $rules = [
        "name" => "required|string",
        "price" => "required|numeric",
        "vendorID" => "required|exists:vendors,id",
        "photo" => "required|image|max:2048",
    ];


    protected $messages = [
        "photo.max" => "Image must be not be more than 2MB",
        "photo.required" => "Image is required",
        "vendorID.exists" => "Invalid vendor selected",
    ];

    public function render()
    {

        if (User::find(Auth::id())->hasRole('admin')) {
            $vendors = Vendor::active()->get();
        } else {
            $vendors = Vendor::active()->where('id', Auth::user()->vendor_id)->get();
        }

        $user = User::find(Auth::id());
        if ($user->hasRole('admin')) {
            $vendors = Vendor::active()->get();
        } elseif ($user->hasRole('city-admin')) {
            $vendors = Vendor::active()->where('creator_id', Auth::id())->get();
        } else {
            $vendors = Vendor::active()->where('id', Auth::user()->vendor_id)->get();
        }


        return view('livewire.products', [
            "vendors" => $vendors,
            "menus" => Menu::active()->where('vendor_id', $this->vendorID)->get(),
            "categories" => Category::active()->get(),
            "subcategories" => $this->subCategories ?? [],
        ]);
    }


    public function showCreateModal()
    {
        $this->reset();
        $this->showCreate = true;
        if (User::find(Auth::id())->hasRole('admin')) {
            $this->vendorID = Vendor::active()->first()->id ?? null;
        } else {
            $this->vendorID = Auth::user()->vendor_id;
        }

        $this->showSelect2("#vendorSelect2", $this->vendorID, "vendorChange");
        $this->showSelect2("#categoriesSelect2", $this->categoriesIDs, "categoriesChange");
        $this->vendorChange($this->vendorID);
    }

    public function save()
    {
        //validate
        $this->validate();

        try {

            DB::beginTransaction();
            $model = new Product();
            $model->name = $this->name;
            $model->description = $this->description;
            $model->price = $this->price;
            $model->discount_price = $this->discount_price;
            $model->capacity = $this->capacity;
            $model->unit = $this->unit;
            $model->package_count = $this->package_count;
            $model->available_qty = !empty($this->available_qty) ? $this->available_qty : null;
            $model->vendor_id = $this->vendorID;
            $model->featured = $this->featured ?? false;
            $model->deliverable = $this->deliverable;
            $model->is_active = $this->isActive;
            $model->save();

            if ($this->photo) {

                $model->clearMediaCollection();
                $model->addMedia($this->photo->getRealPath())->toMediaCollection();
                $this->photo = null;
            }

            //
            $model->categories()->attach($this->categoriesIDs);

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Product created successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Product creation failed!");
        }
    }

    // Updating model
    public function initiateEdit($id)
    {
        $this->selectedModel = $this->model::find($id);
        $this->name = $this->selectedModel->name;
        $this->description = $this->selectedModel->description;
        $this->price = $this->selectedModel->price;
        $this->discount_price = $this->selectedModel->discount_price;
        $this->capacity = $this->selectedModel->capacity;
        $this->unit = $this->selectedModel->unit;
        $this->package_count = $this->selectedModel->package_count;
        $this->available_qty = $this->selectedModel->available_qty;
        $this->vendorID = $this->selectedModel->vendor_id;
        $this->featured = $this->selectedModel->featured;
        $this->deliverable = $this->selectedModel->deliverable;
        $this->isActive = $this->selectedModel->is_active;


        $this->emit('showEditModal');
        $this->showSelect2("#vendorSelect2", $this->vendorID, "vendorChange");
        $this->categoriesIDs = $this->selectedModel->categories()->pluck('category_id');
        $this->showSelect2("#editCategoriesSelect2", $this->categoriesIDs, "categoriesChange");
        $this->vendorChange($this->vendorID);
    }

    public function update()
    {
        //validate
        $this->validate(
            [
                "name" => "required|string",
                "price" => "required|numeric",
                "vendorID" => "required|exists:vendors,id",
                "photo" => "nullable|sometimes|image|max:2048",
            ]
        );

        try {

            DB::beginTransaction();
            $model = $this->selectedModel;
            $model->name = $this->name;
            $model->description = $this->description;
            $model->price = $this->price;
            $model->discount_price = $this->discount_price;
            $model->capacity = $this->capacity;
            $model->unit = $this->unit;
            $model->package_count = $this->package_count;
            $model->available_qty = !empty($this->available_qty) ? $this->available_qty : null;
            $model->vendor_id = $this->vendorID;
            $model->featured = $this->featured ?? false;
            $model->deliverable = $this->deliverable;
            $model->is_active = $this->isActive;
            $model->save();

            if ($this->photo) {

                $model->clearMediaCollection();
                $model->addMedia($this->photo->getRealPath())->toMediaCollection();
                $this->photo = null;
            }

            //
            $model->categories()->sync($this->categoriesIDs);

            DB::commit();

            $this->dismissModal();
            $this->reset();
            $this->showSuccessAlert("Product updated successfully!");
            $this->emit('refreshTable');
        } catch (Exception $error) {
            DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Product updated failed!");
        }
    }

    //

    // Updating model
    public function initiateAssign($id)
    {

        $this->selectedModel = $this->model::find($id);
        $this->menusIDs = $this->selectedModel->menus()->pluck('id')->toArray();
        $this->menusIDs = array_map(
            function ($value) {
                return (string)$value;
            },
            $this->menusIDs
        );
        $this->vendorID = $this->selectedModel->vendor_id;
        $this->emit('showAssignModal');
    }

    public function assignMenus()
    {

        //
        $this->selectedModel->menus()->sync($this->menusIDs);
        $this->dismissModal();
        $this->reset();
        $this->showSuccessAlert("Product updated successfully!");
        $this->emit('refreshTable');
    }

    // Updating subcategories
    public function initiateSubcategoriesAssign($id)
    {

        $this->selectedModel = $this->model::find($id);
        $this->subCategoriesIDs = $this->selectedModel->sub_categories()->pluck('id')->toArray();
        $this->subCategoriesIDs = array_map(
            function ($value) {
                return (string)$value;
            },
            $this->subCategoriesIDs
        );
        //
        $productCategoriesID = $this->selectedModel->categories()->pluck('id')->toArray();
        $this->subCategories = Subcategory::whereIn('category_id', $productCategoriesID)->get();
        $this->showAssignSubcategories = true;
    }


    public function assignSubcategories()
    {

        //
        $this->selectedModel->sub_categories()->sync($this->subCategoriesIDs);
        $this->dismissModal();
        $this->reset();
        $this->showSuccessAlert("Product updated successfully!");
        $this->emit('refreshTable');
    }






    // 
    public function vendorChange($data)
    {
        $this->vendorID = $data;
    }

    public function categoriesChange($data)
    {
        $this->categoriesIDs = $data;
    }
}
