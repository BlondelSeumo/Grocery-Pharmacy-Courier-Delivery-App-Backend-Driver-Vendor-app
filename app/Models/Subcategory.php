<?php

namespace App\Models;

class Subcategory extends BaseModel
{

    public function category()
    {
        return $this->belongsTo('App\Models\Category');
    }

    public function products()
    {
        return $this->belongsToMany('App\Models\Product');
    }


}
