<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class CouponsTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('coupons')->delete();
        
        \DB::table('coupons')->insert(array (
            0 => 
            array (
                'id' => 1,
                'code' => 'BLACK-FRIDAY',
                'description' => 'New Coupon',
                'discount' => 10.0,
                'percentage' => 1,
                'expires_on' => '2021-01-12',
                'times' => NULL,
                'is_active' => 1,
                'created_at' => '2021-01-31 22:05:21',
                'updated_at' => '2021-01-31 23:08:27',
            ),
            1 => 
            array (
                'id' => 2,
                'code' => 'JOAOGATO',
                'description' => NULL,
                'discount' => 10.0,
                'percentage' => 1,
                'expires_on' => '2021-01-28',
                'times' => NULL,
                'is_active' => 1,
                'created_at' => '2021-01-31 23:28:35',
                'updated_at' => '2021-01-31 23:28:35',
            ),
            2 => 
            array (
                'id' => 3,
                'code' => 'USD',
            'description' => ' A flat bread (just like the Greeks used to bake long time back) layered with juicy tomato sauce and topped with fresh veggies as pizza toppings and shredded mozzarella cheese is now, better known as nothing but Pizza.',
                'discount' => 10.1,
                'percentage' => 0,
                'expires_on' => '2021-03-06',
                'times' => NULL,
                'is_active' => 1,
                'created_at' => '2021-01-31 23:29:26',
                'updated_at' => '2021-01-31 23:29:26',
            ),
            3 => 
            array (
                'id' => 4,
                'code' => 'INR',
                'description' => 'Sweet drink',
                'discount' => 10.1,
                'percentage' => 1,
                'expires_on' => '2021-03-25',
                'times' => NULL,
                'is_active' => 1,
                'created_at' => '2021-02-01 00:36:01',
                'updated_at' => '2021-02-01 00:36:01',
            ),
            4 => 
            array (
                'id' => 5,
                'code' => 'USD2',
                'description' => 'Accept credit card from users 12',
                'discount' => 10.0,
                'percentage' => 1,
                'expires_on' => '2021-03-24',
                'times' => NULL,
                'is_active' => 1,
                'created_at' => '2021-02-01 00:37:13',
                'updated_at' => '2021-02-01 01:35:21',
            ),
        ));
        
        
    }
}