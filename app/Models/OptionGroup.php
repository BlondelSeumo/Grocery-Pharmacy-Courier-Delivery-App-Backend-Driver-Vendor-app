<?php

namespace App\Models;

class OptionGroup extends BaseModel
{


    public function options()
    {
        return $this->hasMany('App\Models\Option', 'option_group_id', 'id');
    }


}
