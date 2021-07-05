<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class PackageTypesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {


        \DB::table('package_types')->delete();

        \DB::table('package_types')->insert(array (
            0 =>
            array (
                'id' => 1,
                'name' => 'Documents',
                'is_active' => 1,
                'created_at' => '2021-02-28 01:57:25',
                'updated_at' => '2021-02-28 01:57:25',
                'description' => 'Send documents and latters to your love ones',
            ),
            1 =>
            array (
                'id' => 2,
                'name' => 'Parcel',
                'is_active' => 1,
                'created_at' => '2021-02-28 01:57:25',
                'updated_at' => '2021-02-28 01:57:25',
                'description' => 'Send documents and latters to your love ones',
            ),
        ));


    }
}
