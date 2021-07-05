<?php

namespace App\Models;


class Product extends BaseModel
{

    protected $fillable = [
        "id","name","description","price","discount_price","capacity","unit","package_count","available_qty","featured","deliverable","is_active","vendor_id"
    ];

    protected $appends = ['formatted_date', 'photo', 'is_favourite'];
    protected $with = ['vendor'];

    public function scopeActive($query){
        return $query->where('is_active', 1)->whereHas('vendor', function($q){
            $q->where('is_active', 1);
         });
    }

    public function vendor()
    {
        return $this->belongsTo('App\Models\Vendor', 'vendor_id', 'id');
    }

    public function categories()
    {
        return $this->belongsToMany('App\Models\Category');
    }

    public function sub_categories()
    {
        return $this->belongsToMany('App\Models\Subcategory');
    }
    
    public function menus()
    {
        return $this->belongsToMany('App\Models\Menu');
    }

    public function options()
    {
        return $this->hasMany('App\Models\Option', 'product_id', 'id');
    }

    public function option_groups()
    {
        return $this->hasManyThrough(
            OptionGroup::class,
            Option::class,
            'product_id', // Foreign key on the Option table...
            'id', // Foreign key on the OptionGroup table...
            'id', // Local key on the product table...
            'option_group_id' // Local key on the Option table...
        )->groupBy('id');
    }

    public function sales(){
      return $this->hasMany('App\Models\OrderProduct', 'product_id', 'id');
    }

    public function purchases(){
      return $this->hasMany('App\Models\OrderProduct')->whereHas(
          "order",function($query){
            return $query->where("user_id",  auth('sanctum')->user()->id );
          }
        );
    }

    public function getIsFavouriteAttribute(){

        if( auth('sanctum')->user() ){
            return $this->favourite ? true : false;
        }else{
            return false;
        }

    }

    public function favourite(){
        return $this->belongsTo('App\Models\Favourite', 'id', 'product_id')->where("user_id", "=", auth('sanctum')->user()->id );
    }

}
