<?php

namespace Database\Seeders;

use App\Models\Vendor;
use Illuminate\Database\Seeder;

class VendorsTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {


        \DB::table('vendors')->delete();

        $faker = \Faker\Factory::create();

        for( $i = 0; $i < 7; $i++){
            $model = new Vendor();
            $model->name = $faker->company;
            $model->description = $faker->catchPhrase;
            $model->delivery_fee = $faker->randomNumber(2, false);
            $model->delivery_range = $faker->randomNumber(3, false);
            $model->tax = $faker->randomNumber(2, false);
            $model->phone = $faker->phoneNumber;
            $model->email = $faker->email;
            $model->address = $faker->address;
            $model->latitude = $faker->latitude();
            $model->longitude = $faker->longitude();
            $model->tax = rand(0,1);
            $model->pickup = rand(0,1);
            $model->delivery = rand(0,1);
            $model->is_active = 1;
            if( $i % 6 == 0 ){
                $model->is_package_vendor = 1;
            }
            $model->save();

            //categories
            $model->categories()->attach(rand(1,11));

            //
            $model->addMediaFromUrl( "https://source.unsplash.com/800x480/?logo" )->toMediaCollection("logo");
            $model->addMediaFromUrl( "https://source.unsplash.com/1280x720/?vendor" )->toMediaCollection("feature_image");
        }

        // \DB::table('vendors')->insert(array (
        //     0 =>
        //     array (
        //         'id' => 1,
        //         'name' => 'Hello',
        //         'description' => 'Testing',
        //         'delivery_fee' => 0.0,
        //         'delivery_range' => 0.0,
        //         'tax' => NULL,
        //         'phone' => '0557484181',
        //         'email' => NULL,
        //         'address' => 'Nii boi town, Lapaz, Accra',
        //         'latitude' => NULL,
        //         'longitude' => NULL,
        //         'commission' => 0.0,
        //         'pickup' => 1,
        //         'delivery' => 0,
        //         'is_active' => 1,
        //         'created_at' => '2021-01-08 00:40:39',
        //         'updated_at' => '2021-01-08 21:34:05',
        //     ),
        //     1 =>
        //     array (
        //         'id' => 2,
        //         'name' => 'Buyers Food',
        //         'description' => 'Get a discount up to #500 on your first trip with CT Taxi',
        //         'delivery_fee' => 10.0,
        //         'delivery_range' => 100.0,
        //         'tax' => '12',
        //         'phone' => '+10557484181',
        //         'email' => 'bakoambrose@gmail.com',
        //         'address' => NULL,
        //         'latitude' => 5.0,
        //         'longitude' => -0.20999999999999996,
        //         'commission' => 10.0,
        //         'pickup' => 1,
        //         'delivery' => 1,
        //         'is_active' => 1,
        //         'created_at' => '2021-01-08 01:17:59',
        //         'updated_at' => '2021-01-08 21:27:52',
        //     ),
        // ));


    }
}
