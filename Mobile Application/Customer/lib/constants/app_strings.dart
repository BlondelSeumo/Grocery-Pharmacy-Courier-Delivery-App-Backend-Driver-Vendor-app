import 'dart:convert';

import 'package:fuodz/services/local_storage.service.dart';
import 'package:supercharged_dart/supercharged_dart.dart';

class AppStrings {
  //
  static String get appName => env('app_name');
  static String get companyName => env('company_name');
  static String get googleMapApiKey => env('google_maps_key');
  static String get fcmApiKey => env('fcm_key');
  static String get currencySymbol => env('currency');
  static String get countryCode => env('country_code');
  static bool get enableOtp => env('enble_otp') == "1";
  static bool get enableFood => env('enableFood') == "1";
  static bool get enableParcel => env('enableParcel') == "1";
  static bool get enableSingleVendor => env('enableSingleVendor') == "1";
  static bool get enableGroceryMode => env('enableGroceryMode') == "1";
  static bool get enableReferSystem => env('enableReferSystem') == "1";
  static bool get enableChat => env('enableChat') == "1";
  static bool get enableParcelMultipleStops => env('enableParcelMultipleStops') == "1";
  static int get maxParcelStops => env('maxParcelStops').toInt() ?? 1;
  static String get what3wordsApiKey => env('what3wordsApiKey') ?? "";
  static bool get isWhat3wordsApiKey => what3wordsApiKey.isNotEmpty;

  //DONT'T TOUCH
  static const String notificationChannel = "high_importance_channel";

  //START DON'T TOUNCH
  //for app usage
  static String firstTimeOnApp = "first_time";
  static String authenticated = "authenticated";
  static String userAuthToken = "auth_token";
  static String userKey = "user";
  static String appLocale = "locale";
  static String notificationsKey = "notifications";
  static String appCurrency = "currency";
  static String appColors = "colors";
  static String appRemoteSettings = "appRemoteSettings";
  //END DON'T TOUNCH

  //
  //Change to your app store id
  static String appStoreId = "";

  //
  //saving
  static Future<bool> saveAppSettingsToLocalStorage(String stringMap) async {
    return await LocalStorageService.prefs
        .setString(AppStrings.appRemoteSettings, stringMap);
  }

  static dynamic appSettingsObject;
  static Future<void> getAppSettingsFromLocalStorage() async {
    appSettingsObject =
        LocalStorageService.prefs.getString(AppStrings.appRemoteSettings);
    if (appSettingsObject != null) {
      appSettingsObject = jsonDecode(appSettingsObject);
    }
  }

  static String env(String ref) {
    //
    getAppSettingsFromLocalStorage();
    //
    return appSettingsObject != null ? appSettingsObject[ref] : "";
  }

  //
  static List<String> get orderCancellationReasons {
    return [
      "Long pickup time",
      "Vendor is too slow",
      "custom"
    ];
  }
}
