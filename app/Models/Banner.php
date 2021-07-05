<?php

namespace App\Models;

class Banner extends BaseModel
{

    protected $appends = ['formatted_date', 'photo'];
    protected $with = ["category"];

    public function category()
    {
        return $this->hasOne('App\Models\Category', 'id', 'category_id');
    }
}
