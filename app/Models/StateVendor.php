<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StateVendor extends Model
{
    use HasFactory;
    public $table = "state_vendor";

    public function state()
    {
        return $this->belongsTo(State::class);
    }
    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }
}
