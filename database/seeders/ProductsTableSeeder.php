<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;


class ProductsTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {


        \DB::table('products')->delete();

        $faker = \Faker\Factory::create();
        $faker->addProvider(new \FakerRestaurant\Provider\en_US\Restaurant($faker));

        for( $i = 0; $i < 20; $i++){
            $model = new Product();
            $model->name = $this->productName($faker, $model->category_id);
            $model->description = $faker->paragraph();
            $model->price = $faker->randomNumber(2, false);
            $model->discount_price = $faker->randomNumber(1, false);
            $model->capacity = "".$faker->randomNumber(5, false)."";
            $model->unit = "ml";
            $model->package_count = $faker->randomNumber(1, false);
            $model->featured = rand(0,1);
            $model->deliverable = rand(0,1);
            $model->is_active = 1;
            $model->vendor_id = rand(1,7);
            $model->save();

            //
            $imageUrl = str_ireplace(" ","", $model->name);
            $model->addMediaFromUrl( "https://source.unsplash.com/1280x720/?product,".$imageUrl."" )->toMediaCollection();
        }

        // \DB::table('products')->insert(array (
        //     0 =>
        //     array (
        //         'id' => 1,
        //         'name' => 'Milk',
        //         'description' => 'Very sweet milk',
        //         'price' => 3.5,
        //         'discount_price' => 0.0,
        //         'capacity' => '300',
        //         'unit' => 'ml',
        //         'package_count' => '1',
        //         'featured' => 1,
        //         'deliverable' => 1,
        //         'is_active' => 1,
        //         'vendor_id' => 2,
        //         'category_id' => 1,
        //         'created_at' => '2021-01-09 00:44:51',
        //         'updated_at' => '2021-01-09 10:09:29',
        //     ),
        //     1 =>
        //     array (
        //         'id' => 2,
        //         'name' => 'Carrot',
        //     'description' => ' A flat bread (just like the Greeks used to bake long time back) layered with juicy tomato sauce and topped with fresh veggies as pizza toppings and shredded mozzarella cheese is now, better known as nothing but Pizza.',
        //         'price' => 3.0,
        //         'discount_price' => 0.5,
        //         'capacity' => '1',
        //         'unit' => 'g',
        //         'package_count' => '6',
        //         'featured' => 1,
        //         'deliverable' => 1,
        //         'is_active' => 1,
        //         'vendor_id' => 2,
        //         'category_id' => 2,
        //         'created_at' => '2021-01-09 09:56:55',
        //         'updated_at' => '2021-01-09 10:08:24',
        //     ),
        // ));


    }


    public function productName( $faker, $categoryID ){
        $name = "";
        switch( $categoryID ){
            case 1:
                $name = $faker->beverageName();
                break;
            case 2:
                $name = $faker->dairyName();
                break;
            case 3:
                $name = $faker->dairyName();
                break;
            case 4:
                $name = $faker->dairyName();
                break;
            case 5:
                $name = $faker->foodName();
                break;
            case 6:
                $name = $faker->meatName();
                break;
            case 7:
                $name = $faker->vegetableName();
                break;
            default:
                $name = $faker->foodName();
                break;
        }
        return $name;
    }
}
