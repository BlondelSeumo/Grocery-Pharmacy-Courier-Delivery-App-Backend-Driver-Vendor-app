<?php

namespace App\Models;
use Illuminate\Support\Str;

class PaymentMethod extends BaseModel
{

    protected $fillable = ["slug", "name", "is_active", "is_cash"];
    protected $hidden = ["secret_key", "public_key", "hash_key"];
    
    public static function boot()
    {
        parent::boot();

        self::creating(function($model){
            $model->slug = Str::slug($model->name);
            $model->save();
        });
    }


    public function scopeTopUp($query)
    {
        return $query->where('is_cash', 0);
    }

}
