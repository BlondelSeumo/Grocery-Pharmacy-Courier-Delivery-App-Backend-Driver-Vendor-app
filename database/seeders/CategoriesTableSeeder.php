<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class CategoriesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {

        $categories = ["Beverages", "Bakery", "Dairy", "Baking Goods", "Frozen Foods", "Meat", "Produce", "Cleaners", "Paper Goods", "Personal Care", "Other"];
        $categoriesImages = [
            "https://img.icons8.com/fluent/344/mini-bar.png",
            "https://img.icons8.com/color/344/bakery.png",
            "https://img.icons8.com/plasticine/344/milk-bottle.png",
            "https://img.icons8.com/fluent/344/bread-loaf.png",
            "https://img.icons8.com/emoji/344/soft-ice-cream-emoji.png",
            "https://img.icons8.com/emoji/344/soft-ice-cream-emoji.png",
            "https://img.icons8.com/cotton/344/vegetables-box--v1.png",
            "https://img.icons8.com/office/344/washing-machine.png",
            "https://img.icons8.com/doodle/344/toilet-paper--v1.png",
            "https://img.icons8.com/bubbles/344/soap.png",
            "https://img.icons8.com/fluent/344/similar-items.png",
        ];
        \DB::table('categories')->delete();

        foreach( $categories as $key => $category ){
            $model = new Category();
            $model->name = $category;
            $model->is_active = 1;
            $model->save();
            
            try{
            $model->addMediaFromUrl( $categoriesImages[$key] )->toMediaCollection();
            }catch(\Exception $ex){

            }

        }

        // \DB::table('categories')->insert(array (
        //     0 =>
        //     array (
        //         'id' => 1,
        //         'name' => 'Vegetables',
        //         'is_active' => 1,
        //         'created_at' => '2021-01-08 20:13:34',
        //         'updated_at' => '2021-01-08 20:13:34',
        //     ),
        //     1 =>
        //     array (
        //         'id' => 2,
        //         'name' => 'Liquor',
        //         'is_active' => 1,
        //         'created_at' => '2021-01-08 20:13:56',
        //         'updated_at' => '2021-01-08 20:13:56',
        //     ),
        // ));


    }
}
