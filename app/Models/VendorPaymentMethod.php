<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VendorPaymentMethod extends Model
{
    use HasFactory;
    public $table = "payment_method_vendor";
    public $timestamps = false;

    public function payment_method()
    {
        return $this->belongsTo(PaymentMethod::class);
    }
    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }
}
