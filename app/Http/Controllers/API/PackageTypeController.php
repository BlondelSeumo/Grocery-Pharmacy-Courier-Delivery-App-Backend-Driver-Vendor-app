<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\PackageType;
use Illuminate\Http\Request;


class PackageTypeController extends Controller
{

    //
    public function index(Request $request){
        return PackageType::active()->get();
    }



}
