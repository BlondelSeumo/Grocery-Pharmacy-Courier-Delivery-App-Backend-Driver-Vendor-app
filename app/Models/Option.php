<?php

namespace App\Models;

class Option extends BaseModel
{

    public function product()
    {
        return $this->belongsTo('App\Models\Product', 'product_id', 'id');
    }

    public function option_group()
    {
        return $this->belongsTo('App\Models\OptionGroup', 'option_group_id', 'id');
    }

}
