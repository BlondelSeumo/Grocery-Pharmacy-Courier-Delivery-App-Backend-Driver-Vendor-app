<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class OrdersTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {


        \DB::table('orders')->delete();

        \DB::table('orders')->insert(array (
            0 =>
            array (
                'id' => 1,
                'code' => 'sdsds',
                'note' => 'testing',
                'status' => 'preparing',
                'payment_status' => 'successful',
                'sub_total' => 560.33,
                'delivery_fee' => 10.4,
                'commission' => 2.0,
                'tax' => 4.6,
                'delivery_address_id' => 1,
                'payment_method_id' => 1,
                'vendor_id' => 2,
                'user_id' => 1,
                'driver_id' => NULL,
                'created_at' => '2021-01-09 12:40:43',
                'updated_at' => '2021-01-09 12:40:43',
            ),
            1 =>
            array (
                'id' => 2,
                'code' => 'sdsdsssd',
                'note' => 'testing',
                'status' => 'preparing',
                'payment_status' => 'successful',
                'sub_total' => 560.33,
                'delivery_fee' => 10.4,
                'commission' => 2.0,
                'tax' => 4.6,
                'delivery_address_id' => 1,
                'payment_method_id' => 1,
                'vendor_id' => 2,
                'user_id' => 1,
                'driver_id' => NULL,
                'created_at' => '2021-01-09 12:40:43',
                'updated_at' => '2021-01-09 12:40:43',
            ),
        ));


    }
}
