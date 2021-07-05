<?php

namespace App\Http\Livewire\Tables;

use App\Models\Favourite;
use App\Models\Product;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Kdion4891\LaravelLivewireTables\Column;

class FavouriteTable extends BaseTableComponent
{

    public $model = Favourite::class;

    public function query()
    {
        return Favourite::with('user','product');
    }

    public function columns()
    {
        return [
            Column::make('ID')->searchable()->sortable(),
            Column::make('Product','product.name')->searchable()->sortable(),
            Column::make('User', 'user.name')->searchable()->sortable(),
        ];
    }


}
