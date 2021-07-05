<?php

namespace App\Models;

use Malhal\Geographical\Geographical;
use Illuminate\Support\Facades\Auth;
use willvincent\Rateable\Rateable;
use Carbon\Carbon;

class Vendor extends BaseModel
{

    use  Geographical, Rateable;
    protected static $kilometers = true;
    protected $casts = [ 'id' => 'integer', 'allow_schedule_order' => 'boolean', 'has_sub_categories' => 'boolean' ];
    protected $appends = ['formatted_date', 'logo', 'feature_image', 'type', 'rating', 'can_rate', 'is_open', 'slots'];

    protected $fillable = [
        "id", "name", "description", "delivery_fee", "delivery_range", "tax", "phone", "email", "address", "latitude", "longitude", "commission", "pickup", "delivery", "is_active", "charge_per_km", "is_open", "is_package_vendor"
    ];

    public function registerMediaCollections(): void
    {
        $this
            ->addMediaCollection('logo')
            ->useFallbackUrl('' . url('') . '/images/default.png')
            ->useFallbackPath(public_path('/images/default.png'));
        $this
            ->addMediaCollection('feature_image')
            ->useFallbackUrl('' . url('') . '/images/default.png')
            ->useFallbackPath(public_path('/images/default.png'));
    }

    public function scopeIsPackageDelivery($query)
    {
        return $query->where('is_package_vendor', 1);
    }

    public function scopeRegularVendor($query)
    {
        return $query->where('is_package_vendor', 0);
    }

    public function scopeMine($query)
    {

        return $query->when(Auth::user()->hasRole('manager'), function ($query) {
            return $query->where('id', Auth::user()->vendor_id);
        })->when( Auth::user()->hasRole('city-admin'), function ($query) {
            return $query->where('creator_id', Auth::id());
        });
    }

    public function getLogoAttribute()
    {
        return $this->getFirstMediaUrl('logo');
    }
    public function getFeatureImageAttribute()
    {
        return $this->getFirstMediaUrl('feature_image');
    }

    public function getTypeAttribute()
    {
        return !$this->is_package_vendor ? "Regular" : "Package";
    }

    public function getRatingAttribute()
    {
        return  (int) ($this->averageRating ?? 3);
    }

    public function getIsOpenAttribute()
    {
        if (count($this->days) == 0) {
            return true;
        } else if (count($this->openToday) > 0 && count($this->openNow) > 0) {
            return true;
        } else {
            return false;
        }
    }

    public function getCanRateAttribute()
    {

        if (empty(Auth::user())) {
            return false;
        }
        //
        $vendorReview = Review::where('user_id', Auth::id())->where('vendor_id', $this->id)->first();
        return empty($vendorReview);
    }

    public function getSlotsAttribute()
    {

        $slots = [];
        $days = $this->days->pluck('name')->toArray();
        $daysTiming = $this->days;
        if (!empty($days)) {
            //max order schedule days
            $daysCount = setting('maxScheduledDay', 5) + 1;
            $maxScheduledTime = setting('maxScheduledTime', 2);
            for ($i = 1; $i < $daysCount; $i++) {
                $date = Carbon::now()->addDays($i);
                $dateDayName = $date->format('l');
                try {
                    if (in_array($dateDayName, $days)) {
                        $schuldeInfo = [];
                        $schuldeInfo["date"] = $date;
                        //times
                        $dayTimingIndex = array_search($dateDayName, $days);
                        $dayTiming = $daysTiming[$dayTimingIndex];

                        $hoursdIFF = $this->calculateDiffInHours($dayTiming->pivot->open, $dayTiming->pivot->close);
                        $hoursdIFF -= $maxScheduledTime;
                        if (!empty($hoursdIFF)) {
                            $dateTiming = [];
                            for ($j = 1; $j < $hoursdIFF; $j++) {
                                $time = $this->carbonFromTime($dayTiming->pivot->open)->addHours($j)->format('H:s:i');
                                array_push($dateTiming, $time);
                            }
                            $schuldeInfo["times"] = $dateTiming;
                            //
                            array_push($slots, $schuldeInfo);
                        }
                    }
                } catch (\Exception $ex) {
                    logger("Error", [$ex]);
                }
            }
        }

        return $slots;
    }





    //RELATIONSHIPS
    public function earning()
    {
        return $this->hasOne('App\Models\Earning', 'vendor_id', 'id');
    }

    public function managers()
    {
        return $this->hasMany('App\Models\User', 'vendor_id', 'id');
    }

    public function sales()
    {
        return $this->hasMany('App\Models\Order', 'vendor_id', 'id');
    }

    public function categories()
    {
        return $this->belongsToMany('App\Models\Category');
    }

    public function days()
    {
        return $this->belongsToMany('App\Models\Day')->withPivot('day_id', 'open', 'close');
    }

    public function products()
    {
        return $this->hasMany('App\Models\Product', 'vendor_id', 'id');
    }

    public function menus()
    {
        return $this->hasMany('App\Models\Menu');
    }

    public function cities()
    {
        return $this->belongsToMany('App\Models\City');
    }
    public function states()
    {
        return $this->belongsToMany('App\Models\State');
    }
    public function countries()
    {
        return $this->belongsToMany('App\Models\Country');
    }



    // public function product_menus()
    // {

    //     return $this->hasManyThrough(
    //         Menu::class,
    //         Product::class,
    //         'vendor_id', // Foreign key on the Product table...
    //         'id', // Foreign key on the Category table...
    //         'id', // Local key on the product table...
    //         'menu_id' // Local key on the Product table...
    //     )->groupBy('id')->distinct();
    // }

    public function package_types_pricing()
    {
        return $this->hasMany('App\Models\PackageTypePricing', 'vendor_id', 'id');
    }

    public function openToday()
    {
        $now = Carbon::now();
        $todayName = $now->format('l');
        return $this->belongsToMany('App\Models\Day')->withPivot('open', 'close')->where('name', $todayName);
    }

    public function openNow()
    {
        $now = Carbon::now();
        $nowTime = $now->format('H:i:s');
        return $this->belongsToMany('App\Models\Day')->withPivot('open', 'close')->whereTime('open', '<=', $nowTime)->whereTime('close', '>', $nowTime);
    }
}
