<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DaysTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('days')->delete();
        
        \DB::table('days')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'Sunday',
                'created_at' => '2021-05-04 08:09:30',
                'updated_at' => '2021-05-04 08:09:30',
            ),
            1 => 
            array (
                'id' => 2,
                'name' => 'Monday',
                'created_at' => '2021-05-04 08:09:30',
                'updated_at' => '2021-05-04 08:09:30',
            ),
            2 => 
            array (
                'id' => 3,
                'name' => 'Tuesday',
                'created_at' => '2021-05-04 08:09:30',
                'updated_at' => '2021-05-04 08:09:30',
            ),
            3 => 
            array (
                'id' => 4,
                'name' => 'Wednesday',
                'created_at' => '2021-05-04 08:09:30',
                'updated_at' => '2021-05-04 08:09:30',
            ),
            4 => 
            array (
                'id' => 5,
                'name' => 'Thursday',
                'created_at' => '2021-05-04 08:09:30',
                'updated_at' => '2021-05-04 08:09:30',
            ),
            5 => 
            array (
                'id' => 6,
                'name' => 'Friday',
                'created_at' => '2021-05-04 08:09:30',
                'updated_at' => '2021-05-04 08:09:30',
            ),
            6 => 
            array (
                'id' => 7,
                'name' => 'Saturday',
                'created_at' => '2021-05-04 08:09:30',
                'updated_at' => '2021-05-04 08:09:30',
            ),
        ));
        
        
    }
}