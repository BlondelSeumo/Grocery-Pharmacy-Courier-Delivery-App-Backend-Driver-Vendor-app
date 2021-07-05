<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;


class State extends Model
{
    use SoftDeletes;
    protected $fillable = [
        'id','country_id', 'name', 'status'
    ];

    public function getNameAttribute($value){
        return Str::ucfirst($value);
    }

    public function cities()
    {
        return $this->hasMany(City::class);
    }
    public function country()
    {
        return $this->belongsTo(Country::class);
    }
}
