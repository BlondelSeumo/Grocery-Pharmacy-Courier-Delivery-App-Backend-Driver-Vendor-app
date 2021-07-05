<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Country extends Model
{
    use SoftDeletes;
    protected $fillable = [
        'id', 'name', 'status'
    ];

    public function getNameAttribute($value){
        return Str::ucfirst($value);
    }

    public function states()
    {
        return $this->hasMany(State::class);
    }
}
