<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class SettingsTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('settings')->delete();
        
        \DB::table('settings')->insert(array (
            0 => 
            array (
                'id' => 1,
                'key' => 'googleMapKey',
                'value' => 'AIzaSyATm1Umzz6ruzwRIbNV4uC1iAhoRQFaVCY',
            ),
            1 => 
            array (
                'id' => 2,
                'key' => 'currencyCode',
                'value' => 'USD',
            ),
            2 => 
            array (
                'id' => 3,
                'key' => 'currency',
                'value' => '$',
            ),
            3 => 
            array (
                'id' => 4,
                'key' => 'currencyCountryCode',
                'value' => 'US',
            ),
            4 => 
            array (
                'id' => 11,
                'key' => 'appColorTheme.accentColor',
                'value' => '#64bda1',
            ),
            5 => 
            array (
                'id' => 12,
                'key' => 'appColorTheme.primaryColor',
                'value' => '#21a179',
            ),
            6 => 
            array (
                'id' => 13,
                'key' => 'appColorTheme.primaryColorDark',
                'value' => '#146149',
            ),
            7 => 
            array (
                'id' => 14,
                'key' => 'appColorTheme.onboarding1Color',
                'value' => '#F9F9F9',
            ),
            8 => 
            array (
                'id' => 15,
                'key' => 'appColorTheme.onboarding2Color',
                'value' => '#F6EFEE',
            ),
            9 => 
            array (
                'id' => 16,
                'key' => 'appColorTheme.onboarding3Color',
                'value' => '#FFFBFC',
            ),
            10 => 
            array (
                'id' => 17,
                'key' => 'appColorTheme.onboardingIndicatorDotColor',
                'value' => '#30C0D9',
            ),
            11 => 
            array (
                'id' => 18,
                'key' => 'appColorTheme.onboardingIndicatorActiveDotColor',
                'value' => '#21a179',
            ),
            12 => 
            array (
                'id' => 19,
                'key' => 'appColorTheme.openColor',
                'value' => '#00FF00',
            ),
            13 => 
            array (
                'id' => 20,
                'key' => 'appColorTheme.closeColor',
                'value' => '#FF0000',
            ),
            14 => 
            array (
                'id' => 21,
                'key' => 'appColorTheme.deliveryColor',
                'value' => '#FFBF00',
            ),
            15 => 
            array (
                'id' => 22,
                'key' => 'appColorTheme.pickupColor',
                'value' => '#0000FF',
            ),
            16 => 
            array (
                'id' => 23,
                'key' => 'appColorTheme.ratingColor',
                'value' => '#FFBF00',
            ),
            17 => 
            array (
                'id' => 24,
                'key' => 'appColorTheme.pendingColor',
                'value' => '#0099FF',
            ),
            18 => 
            array (
                'id' => 25,
                'key' => 'appColorTheme.preparingColor',
                'value' => '#0000FF',
            ),
            19 => 
            array (
                'id' => 26,
                'key' => 'appColorTheme.enrouteColor',
                'value' => '#00FF00',
            ),
            20 => 
            array (
                'id' => 27,
                'key' => 'appColorTheme.failedColor',
                'value' => '#FF0000',
            ),
            21 => 
            array (
                'id' => 28,
                'key' => 'appColorTheme.cancelledColor',
                'value' => '#808080',
            ),
            22 => 
            array (
                'id' => 29,
                'key' => 'appColorTheme.deliveredColor',
                'value' => '#01A368',
            ),
            23 => 
            array (
                'id' => 30,
                'key' => 'appColorTheme.successfulColor',
                'value' => '#01A368',
            ),
            24 => 
            array (
                'id' => 31,
                'key' => 'serviceKeyPath',
                'value' => 'vault/firebase_service.json',
            ),
            25 => 
            array (
                'id' => 32,
                'key' => 'appName',
                'value' => 'Fuodz',
            ),
            26 => 
            array (
                'id' => 33,
                'key' => 'websiteName',
                'value' => 'Fuodz',
            ),
            27 => 
            array (
                'id' => 34,
                'key' => 'countryCode',
                'value' => 'GH',
            ),
            28 => 
            array (
                'id' => 35,
                'key' => 'websiteLogo',
                'value' => 'http://fuodz-admin.test/images/logo.png',
            ),
            29 => 
            array (
                'id' => 36,
                'key' => 'favicon',
                'value' => 'http://fuodz-admin.test/images/logo.png',
            ),
            30 => 
            array (
                'id' => 37,
                'key' => 'loginImage',
                'value' => 'http://fuodz-admin.test/images/login-office.jpeg',
            ),
            31 => 
            array (
                'id' => 38,
                'key' => 'registerImage',
                'value' => 'http://fuodz-admin.test/images/login-office.jpeg',
            ),
        ));
        
        
    }
}