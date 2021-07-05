<?php

namespace App\Models;


class Payout extends BaseModel
{

    public function user()
    {
        return $this->belongsTo('App\Models\User', 'user_id', 'id');
    }

    public function earning()
    {
        return $this->belongsTo('App\Models\Earning', 'earning_id', 'id');
    }

}
