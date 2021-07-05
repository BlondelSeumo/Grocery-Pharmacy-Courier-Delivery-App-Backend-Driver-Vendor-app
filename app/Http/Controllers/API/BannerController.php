<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\BannerResource;
use App\Models\Banner;
use Illuminate\Http\Request;


class BannerController extends Controller
{

    //
    public function index(Request $request){
        return BannerResource::collection( Banner::active()->get());
    }



}
