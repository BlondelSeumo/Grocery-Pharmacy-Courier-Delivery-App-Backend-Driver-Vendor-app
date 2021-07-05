<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {

        // $this->call(MediaTableSeeder::class);
        $this->call(CountryStateCityTableSeeder::class);
        $this->call(CitiesTableSeeder::class);
        $this->call(CategoriesTableSeeder::class);
        $this->call(VendorsTableSeeder::class);
        $this->call(UsersTableSeeder::class);
        $this->call(RolesTableSeeder::class);
        $this->call(ModelHasRolesTableSeeder::class);
        $this->call(BannersTableSeeder::class);
        $this->call(ProductsTableSeeder::class);
        $this->call(OptionGroupsTableSeeder::class);
        $this->call(OptionsTableSeeder::class);
        $this->call(DeliveryAddressesTableSeeder::class);
        $this->call(PaymentMethodsTableSeeder::class);
        $this->call(OrdersTableSeeder::class);
        $this->call(OrderProductsTableSeeder::class);
        $this->call(CouponsTableSeeder::class);
        $this->call(CouponVendorTableSeeder::class);
        $this->call(CouponProductTableSeeder::class);
        $this->call(CurrenciesTableSeeder::class);
        $this->call(PackageTypesTableSeeder::class);
        $this->call(PackageTypePricingsTableSeeder::class);
        $this->call(SettingsTableSeeder::class);

        $this->call(CityVendorTableSeeder::class);
        $this->call(DaysTableSeeder::class);
    }
}
