<?php

namespace App\Models;

use Malhal\Geographical\Geographical;

use Illuminate\Database\Eloquent\SoftDeletes;

class DeliveryAddress extends BaseModel
{

    use Geographical, SoftDeletes;

    protected static $kilometers = true;

    protected $fillable = [
        'name',
        'address',
        'latitude',
        'longitude',
        'city',
        'state',
        'country',
        'is_default',
        'user_id',
    ];

    protected $casts = [
        'latitude' => "double",
        'longitude' => "double",
    ];

    public static function boot()
    {
        parent::boot();

        self::creating(function ($model) {
            if ($model->is_default == null) {
                $model->is_default = 0;
            }
            //
            $model->makeDefault();
        });

        //
        self::updating(function ($model) {
            if ($model->is_default == null) {
                $model->is_default = 0;
            }

            //
            $model->makeDefault();
        });
    }


    public function makeDefault()
    {

        if ($this->is_default) {
            DeliveryAddress::where('is_default', 1)
                ->where('id', "!=", $this->id)
                ->update(['is_default' => 0]);
        }
    }

    public function user()
    {
        return $this->belongsTo('App\Models\User', 'user_id', 'id');
    }
}
