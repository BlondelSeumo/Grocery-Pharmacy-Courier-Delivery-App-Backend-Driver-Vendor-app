<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class CouponVendorTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {


        \DB::table('coupon_vendor')->delete();

        \DB::table('coupon_vendor')->insert(array(
            0 =>
            array(
                'coupon_id' => 5,
                'vendor_id' => 1,
            ),
            1 =>
            array(
                'coupon_id' => 5,
                'vendor_id' => 2,
            ),
            2 =>
            array(
                'coupon_id' => 5,
                'vendor_id' => 3,
            ),
            3 =>
            array(
                'coupon_id' => 5,
                'vendor_id' => 4,
            ),
            4 =>
            array(
                'coupon_id' => 5,
                'vendor_id' => 5,
            ),
        ));
    }
}
