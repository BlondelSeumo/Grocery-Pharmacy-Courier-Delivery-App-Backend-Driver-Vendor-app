<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DeliveryAddressesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('delivery_addresses')->delete();
        
        \DB::table('delivery_addresses')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'Home',
                'address' => 'Ni boi town Lapaz',
                'latitude' => '5.459902',
                'longitude' => '-0.23434',
                'city' => 'accra',
                'is_default' => 1,
                'user_id' => 1,
                'created_at' => '2021-01-09 12:04:36',
                'updated_at' => '2021-01-09 12:04:36',
            ),
            1 => 
            array (
                'id' => 2,
                'name' => 'Home',
                'address' => '7 Tunemete Street, Accra, Ghana',
                'latitude' => '5.6069210214565',
                'longitude' => '-0.20655892789364',
                'city' => 'accra',
                'is_default' => 1,
                'user_id' => 4,
                'created_at' => '2021-03-01 07:47:27',
                'updated_at' => '2021-03-01 07:47:27',
            ),
            2 => 
            array (
                'id' => 3,
                'name' => 'Office',
                'address' => '11 Otublohum Rd, Accra, Ghana',
                'latitude' => '5.5740240377069',
                'longitude' => '-0.21965883672237',
                'city' => 'accra',
                'is_default' => 0,
                'user_id' => 4,
                'created_at' => '2021-03-01 07:47:51',
                'updated_at' => '2021-03-01 07:47:51',
            ),
        ));
        
        
    }
}