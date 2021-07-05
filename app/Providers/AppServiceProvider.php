<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\Facades\Schema;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {

        Schema::defaultStringLength(191);
        //
        Blade::if('showPackage', function () {
            if (auth()->user() && (auth()->user()->hasRole('admin') || (auth()->user()->vendor ? auth()->user()->vendor->is_package_vendor : false))) {
                return 1;
            }
            return 0;
        });


        //
        Blade::if('showProduct', function () {
            if (auth()->user() && (auth()->user()->hasRole('admin') || (auth()->user()->vendor ? !auth()->user()->vendor->is_package_vendor : true))) {
                return 1;
            }
            return 0;
        });


        //
        try {
            date_default_timezone_set(setting('timeZone', 'UTC'));
        } catch (\Exception $ex) {
            date_default_timezone_set('UTC');
        }        

    }
}
