<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CityVendor extends Model
{
    use HasFactory;
    public $table = "city_vendor";

    public function city()
    {
        return $this->belongsTo(City::class);
    }
    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }
}
