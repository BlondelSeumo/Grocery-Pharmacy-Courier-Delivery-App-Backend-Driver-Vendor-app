<?php

namespace Database\Seeders;

use App\Models\Banner;
use Illuminate\Database\Seeder;

class BannersTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {


        \DB::table('banners')->delete();

        for( $i = 0; $i < 5; $i++){
            $model = new Banner();
            $model->category_id = rand(1,11);
            $model->is_active = 1;
            $model->save();

            //
            $bannerName = str_ireplace(" ","", $model->category->name);
            $model->addMediaFromUrl( "https://source.unsplash.com/1280x720/?banner".$bannerName."" )->toMediaCollection();
        }


    }
}
