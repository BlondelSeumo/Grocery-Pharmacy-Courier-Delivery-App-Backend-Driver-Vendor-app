<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class CouponProductTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('coupon_product')->delete();
        
        \DB::table('coupon_product')->insert(array (
            0 => 
            array (
                'coupon_id' => 5,
                'product_id' => 1,
            ),
            1 => 
            array (
                'coupon_id' => 5,
                'product_id' => 3,
            ),
            2 => 
            array (
                'coupon_id' => 5,
                'product_id' => 4,
            ),
            3 => 
            array (
                'coupon_id' => 5,
                'product_id' => 5,
            ),
            4 => 
            array (
                'coupon_id' => 5,
                'product_id' => 6,
            ),
            5 => 
            array (
                'coupon_id' => 5,
                'product_id' => 7,
            ),
            6 => 
            array (
                'coupon_id' => 5,
                'product_id' => 13,
            ),
            7 => 
            array (
                'coupon_id' => 5,
                'product_id' => 18,
            ),
        ));
        
        
    }
}