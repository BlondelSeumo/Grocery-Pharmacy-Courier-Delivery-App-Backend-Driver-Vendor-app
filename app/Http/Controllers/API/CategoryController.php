<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\CategoryResource;
use App\Models\Category;
use App\Models\Subcategory;
use Illuminate\Http\Request;


class CategoryController extends Controller
{

    //
    public function index(Request $request){
        if($request->type == "sub"){
            return CategoryResource::collection(Subcategory::active()->get());
        }
        return CategoryResource::collection(Category::active()->get());
    }



}
