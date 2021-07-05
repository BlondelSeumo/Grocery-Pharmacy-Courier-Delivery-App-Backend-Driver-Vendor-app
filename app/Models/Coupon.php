<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Coupon extends Model
{
    use HasFactory;

    protected $appends = ['formatted_expires_on'];

    public function getFormattedExpiresOnAttribute(){
        return Carbon::parse($this->expires_on)->format('d M Y');
    }

    public function products()
    {
        return $this->belongsToMany('App\Models\Product');
    }

    public function vendors()
    {
        return $this->belongsToMany('App\Models\Vendor');
    }
}
