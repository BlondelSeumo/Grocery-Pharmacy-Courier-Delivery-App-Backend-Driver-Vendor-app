<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class CurrenciesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {


        \DB::table('currencies')->delete();

        \DB::table('currencies')->insert(array (
            0 =>
            array (
                'id' => 1,
                'name' => 'United States Dollar',
                'code' => 'USD',
                'country_code' => 'US',
                'symbol' => '$',
                'created_at' => '2021-02-22 08:45:07',
                'updated_at' => '2021-02-22 08:49:23',
            ),
            1 =>
            array (
                'id' => 2,
                'name' => 'Indian Rupees',
                'code' => 'INR',
                'country_code' => 'IN',
                'symbol' => '₹',
                'created_at' => '2021-02-22 08:50:34',
                'updated_at' => '2021-02-22 08:50:34',
            ),
            2 =>
            array (
                'id' => 3,
                'name' => 'Ghana Cedis',
                'code' => 'GHS',
                'country_code' => 'GH',
                'symbol' => 'GHS',
                'created_at' => '2021-02-22 12:46:53',
                'updated_at' => '2021-02-22 12:46:53',
            ),
            3 =>
            array (
                'id' => 4,
                'name' => 'Nigeria Naira',
                'code' => 'NGN',
                'country_code' => 'NG',
                'symbol' => '₦',
                'created_at' => '2021-02-22 12:46:53',
                'updated_at' => '2021-02-22 12:46:53',
            ),
        ));


    }
}
