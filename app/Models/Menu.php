<?php

namespace App\Models;


class Menu extends BaseModel
{

    protected $fillable = [
        "id","name","vendor_id","is_active"
    ];

    public function products()
    {
        return $this->belongsToMany('App\Models\Product');
    }

}