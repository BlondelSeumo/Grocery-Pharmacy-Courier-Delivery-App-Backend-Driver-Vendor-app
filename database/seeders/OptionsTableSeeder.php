<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class OptionsTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('options')->delete();
        
        \DB::table('options')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'XL',
                'description' => 'Accept credit card from users 12',
                'price' => 3.0,
                'product_id' => 1,
                'option_group_id' => 1,
                'vendor_id' => 6,
                'is_active' => 1,
                'created_at' => '2021-03-08 23:16:33',
                'updated_at' => '2021-03-08 23:16:33',
            ),
        ));
        
        
    }
}