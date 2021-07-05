<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Currency;
use Illuminate\Http\Request;




class AppSettingsController extends Controller
{

    public function index(Request $request)
    {
        //
        $currency = Currency::where('country_code', setting("currencyCountryCode", "GH"))->first();
        return response()->json([

            "colors" => setting("appColorTheme"),
            "strings" => [
                "google_maps_key" => setting("googleMapKey", ""),
                "fcm_key" => setting('fcmServerKey', ""),
                "app_name" => setting('appName', ""),
                "company_name" => setting('websiteName', ""),
                "enble_otp" => setting('enableOTP', "1"),
                "enableParcel" => setting('enableParcel', "1"),
                "enableFood" => setting('enableFood', "1"),
                "enableSingleVendor" => setting('enableSingleVendor', "1"),                
                "enableProofOfDelivery" => setting('enableProofOfDelivery', "1"),                
                "enableDriverWallet" => setting('enableDriverWallet', "0"),                
                "enableGroceryMode" => setting('enableGroceryMode', "0"),                
                "enableReferSystem" => setting('enableReferSystem', "0"),                
                "enableChat" => setting('enableChat', "1"),                
                "referRewardAmount" => setting('referRewardAmount', "0"),                
                "enableParcelMultipleStops" => setting('enableParcelMultipleStops', "0"),                
                "maxParcelStops" => setting('maxParcelStops', "1"),                
                "what3wordsApiKey" => setting('what3wordsApiKey', ""),                
                "currency" => $currency->symbol,
                "country_code" => setting('appCountryCode', "GH"),
            ],

        ]);
    }
}
