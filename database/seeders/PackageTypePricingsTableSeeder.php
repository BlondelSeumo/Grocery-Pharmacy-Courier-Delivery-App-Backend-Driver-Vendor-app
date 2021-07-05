<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class PackageTypePricingsTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('package_type_pricings')->delete();
        
        \DB::table('package_type_pricings')->insert(array (
            0 => 
            array (
                'id' => 1,
                'vendor_id' => 6,
                'package_type_id' => 2,
                'max_booking_days' => 21,
                'size_price' => 50.0,
                'price_per_kg' => 1,
                'distance_price' => 23.0,
                'price_per_km' => 1,
                'is_active' => 1,
                'created_at' => '2021-02-28 12:55:33',
                'updated_at' => '2021-02-28 12:55:33',
            ),
            1 => 
            array (
                'id' => 2,
                'vendor_id' => 6,
                'package_type_id' => 1,
                'max_booking_days' => 22,
                'size_price' => 50.0,
                'price_per_kg' => 1,
                'distance_price' => 23.0,
                'price_per_km' => 1,
                'is_active' => 1,
                'created_at' => '2021-02-28 12:57:26',
                'updated_at' => '2021-02-28 12:57:26',
            ),
            2 => 
            array (
                'id' => 3,
                'vendor_id' => 7,
                'package_type_id' => 1,
                'max_booking_days' => 34,
                'size_price' => 23.0,
                'price_per_kg' => 1,
                'distance_price' => 12.0,
                'price_per_km' => 1,
                'is_active' => 1,
                'created_at' => '2021-03-08 00:24:04',
                'updated_at' => '2021-03-08 00:24:04',
            ),
            3 => 
            array (
                'id' => 4,
                'vendor_id' => 7,
                'package_type_id' => 2,
                'max_booking_days' => 21,
                'size_price' => 12.0,
                'price_per_kg' => 1,
                'distance_price' => 23.0,
                'price_per_km' => 1,
                'is_active' => 1,
                'created_at' => '2021-03-08 00:24:17',
                'updated_at' => '2021-03-08 00:24:17',
            ),
        ));
        
        
    }
}