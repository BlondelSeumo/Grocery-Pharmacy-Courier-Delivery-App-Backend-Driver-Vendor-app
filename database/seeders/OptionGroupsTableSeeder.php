<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class OptionGroupsTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('option_groups')->delete();
        
        \DB::table('option_groups')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'Size',
                'vendor_id' => 6,
                'multiple' => 1,
                'is_active' => 1,
                'created_at' => '2021-03-08 23:12:32',
                'updated_at' => '2021-03-08 23:12:32',
            ),
            1 => 
            array (
                'id' => 2,
                'name' => 'Color',
                'vendor_id' => 6,
                'multiple' => 1,
                'is_active' => 1,
                'created_at' => '2021-03-08 23:15:16',
                'updated_at' => '2021-03-08 23:15:16',
            ),
        ));
        
        
    }
}