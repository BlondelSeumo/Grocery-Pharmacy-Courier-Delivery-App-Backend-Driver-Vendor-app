<?php

namespace App\Http\Livewire\Tables;

use App\Models\Product;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Kdion4891\LaravelLivewireTables\Column;

class ProductTable extends BaseTableComponent
{

    public $model = Product::class;
    public $header_view = 'components.buttons.new';

    public function query()
    {

        $user = User::find(Auth::id());
        if ($user->hasRole('admin')) {
            return Product::query();
        } elseif ($user->hasRole('city-admin')) {
            return Product::with('vendor')->whereHas("vendor", function ($query) {
                return $query->where('creator_id', Auth::id());
            });
        } else {
            return Product::where("vendor_id", Auth::user()->vendor_id);
        }
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Image')->view('components.table.image_sm'),
            Column::make('Name')->searchable()->sortable(),
            Column::make('Price')->view('components.table.price')->searchable()->sortable(),
            Column::make('Discount Price')->view('components.table.discount_price')->searchable()->sortable(),
            Column::make('Available Qty')->sortable(),
            Column::make('Active')->view('components.table.active'),
            Column::make('Created At', 'formatted_date'),
            Column::make('Actions')->view('components.buttons.product_actions'),
        ];
    }



    //
    public function deleteModel()
    {

        try {
            $this->isDemo();
            \DB::beginTransaction();
            $this->selectedModel->delete();
            \DB::commit();
            $this->showSuccessAlert("Deleted");
        } catch (Exception $error) {
            \DB::rollback();
            $this->showErrorAlert($error->getMessage() ?? "Failed");
        }
    }
}
