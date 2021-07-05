<?php

namespace App\Models;


class PackageTypePricing extends BaseModel
{

    protected $fillable = [
        "vendor_id",
        "package_type_id",
        "max_booking_days",
        "size_price",
        "price_per_kg",
        "distance_price",
        "base_price",
        "price_per_km",
        "is_active",
        "auto_assignment",
        "field_required"
    ];
    protected $casts = ['id' => 'integer', 'field_required' => 'bool'];
    protected $with = ['package_type'];
    public function package_type()
    {
        return $this->belongsTo('App\Models\PackageType', 'package_type_id', 'id');
    }
}
