<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('users')->delete();
        
        \DB::table('users')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'Admin Account',
                'email' => 'admin@demo.com',
                'phone' => '0557484181',
                'email_verified_at' => NULL,
                'password' => '$2y$10$PXQZtHa6QTnz3LWYuAtBcuRTHquy5eZIOIKxLdTWBoZBc3RNYMijy',
                'vendor_id' => NULL,
                'remember_token' => 'RZFvnS3aNlH1wTyolS5zSPUV3TMxrN0M2u9SaTuy4fxJT97rc7wbOf80fhUz',
                'created_at' => '2020-12-28 11:14:31',
                'updated_at' => '2020-12-28 11:14:31',
                'deleted_at' => NULL,
                'is_active' => 1,
            ),
            1 => 
            array (
                'id' => 2,
                'name' => 'Manager Account',
                'email' => 'manager@demo.com',
                'phone' => '0557484190',
                'email_verified_at' => NULL,
                'password' => '$2y$10$uL0Ct5X9c/9grQKs5nfWzucaF2AthWNDSkUNDeK1UiltuN1bcFqnS',
                'vendor_id' => 6,
                'remember_token' => '4Vpdv7vm9L2m6ywZMd4cIZcHK3eUGYI1CvZkW6oGwKQFIrHX4889S31xJzgv',
                'created_at' => '2021-01-08 12:15:16',
                'updated_at' => '2021-03-09 10:49:29',
                'deleted_at' => NULL,
                'is_active' => 1,
            ),
            2 => 
            array (
                'id' => 3,
                'name' => 'Driver account',
                'email' => 'driver@demo.com',
                'phone' => '0557484183',
                'email_verified_at' => NULL,
                'password' => '$2y$10$uL0Ct5X9c/9grQKs5nfWzucaF2AthWNDSkUNDeK1UiltuN1bcFqnS',
                'vendor_id' => NULL,
                'remember_token' => NULL,
                'created_at' => '2021-01-08 12:15:16',
                'updated_at' => '2021-01-08 20:33:00',
                'deleted_at' => NULL,
                'is_active' => 1,
            ),
            3 => 
            array (
                'id' => 4,
                'name' => 'Client Account',
                'email' => 'client@demo.com',
                'phone' => '0557484189',
                'email_verified_at' => NULL,
                'password' => '$2y$10$yExbYa42O0TWGQQ32gYem.9pJH5K5GcQNY1YMgN169A4NFL/AGmDu',
                'vendor_id' => NULL,
                'remember_token' => NULL,
                'created_at' => '2021-02-01 13:14:26',
                'updated_at' => '2021-02-01 13:14:26',
                'deleted_at' => NULL,
                'is_active' => 1,
            ),
            4 => 
            array (
                'id' => 5,
                'name' => 'Manager Account Package Vendor',
                'email' => 'manager1@demo.com',
                'phone' => '0557484191',
                'email_verified_at' => NULL,
                'password' => '$2y$10$uL0Ct5X9c/9grQKs5nfWzucaF2AthWNDSkUNDeK1UiltuN1bcFqnS',
                'vendor_id' => 7,
                'remember_token' => NULL,
                'created_at' => '2021-01-08 12:15:16',
                'updated_at' => '2021-03-09 10:49:14',
                'deleted_at' => NULL,
                'is_active' => 1,
            ),
        ));
        
        
    }
}