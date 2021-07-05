<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CountryVendor extends Model
{
    use HasFactory;
    public $table = "country_vendor";

    public function country()
    {
        return $this->belongsTo(Country::class);
    }
    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }
}
