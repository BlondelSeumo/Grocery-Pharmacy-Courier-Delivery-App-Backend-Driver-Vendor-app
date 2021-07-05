<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class CityVendorTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('city_vendor')->delete();
        
        \DB::table('city_vendor')->insert(array (
            0 => 
            array (
                'id' => 1,
                'city_id' => 48315,
                'vendor_id' => 7,
                'is_active' => 1,
                'created_at' => '2021-03-08 08:51:00',
                'updated_at' => '2021-03-08 08:51:00',
            ),
        ));
        
        
    }
}