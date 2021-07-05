<?php

namespace App\Models;

class Earning extends BaseModel{

    protected $fillable = [
        'user_id',
        'vendor_id',
        'amount',
    ];

    public function user()
    {
        return $this->belongsTo('App\Models\User', 'user_id', 'id');
    }

    public function vendor()
    {
        return $this->belongsTo('App\Models\Vendor', 'vendor_id', 'id');
    }


}
