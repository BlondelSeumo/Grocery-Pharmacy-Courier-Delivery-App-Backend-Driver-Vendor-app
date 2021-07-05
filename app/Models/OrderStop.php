<?php

namespace App\Models;

class OrderStop extends BaseModel
{


    public function delivery_address()
    {
        return $this->belongsTo('App\Models\DeliveryAddress', 'stop_id', 'id');
    }

    public function order()
    {
        return $this->belongsTo('App\Models\Order', 'order_id', 'id');
    }
}
