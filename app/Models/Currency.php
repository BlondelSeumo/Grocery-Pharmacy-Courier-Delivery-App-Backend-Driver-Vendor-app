<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Currency extends Model
{
    use HasFactory;

    public function scopeActive($query){
        return $query->where('country_code', setting("currencyCountryCode", "GH"));
    }
}
