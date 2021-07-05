<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class OrderProductsTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('order_products')->delete();
        
        \DB::table('order_products')->insert(array (
            0 => 
            array (
                'id' => 1,
                'quantity' => 1,
                'price' => 5.0,
                'options' => NULL,
                'order_id' => 1,
                'product_id' => 1,
                'created_at' => '2021-01-09 12:42:16',
                'updated_at' => '2021-01-09 12:42:16',
            ),
            1 => 
            array (
                'id' => 2,
                'quantity' => 5,
                'price' => 5.0,
                'options' => NULL,
                'order_id' => 1,
                'product_id' => 2,
                'created_at' => '2021-01-09 12:42:16',
                'updated_at' => '2021-01-09 12:42:16',
            ),
            2 => 
            array (
                'id' => 3,
                'quantity' => 5,
                'price' => 5.0,
                'options' => NULL,
                'order_id' => 2,
                'product_id' => 2,
                'created_at' => '2021-01-09 12:42:16',
                'updated_at' => '2021-01-09 12:42:16',
            ),
        ));
        
        
    }
}