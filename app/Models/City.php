<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class City extends Model
{
    use SoftDeletes;
    protected $fillable = [
        'id','state_id', 'name', 'status'
    ];

    public function getNameAttribute($value){
        return Str::ucfirst($value);
    }

    public function state()
    {
        return $this->belongsTo(State::class);
    }
}
