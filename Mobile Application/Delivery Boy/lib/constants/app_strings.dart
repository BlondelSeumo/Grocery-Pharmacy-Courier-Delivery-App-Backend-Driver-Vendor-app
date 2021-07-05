import 'dart:convert';

import 'package:fuodz/services/local_storage.service.dart';

class AppStrings {

  //
  static String get appName => env('app_name');
  static String get companyName => env('company_name');
  static String get googleMapApiKey => env('google_maps_key');
  static String get fcmApiKey => env('fcm_key');
  static String get currencySymbol => env('currency');
  static String get countryCode => env('country_code');
  static bool get enableProofOfDelivery => env('enableProofOfDelivery') == "1";
  static bool get enableDriverWallet => env('enableDriverWallet') == "1";
  static bool get enableChat => env('enableChat') == "1";
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
  static String onlineOnApp = "online";
  //END DON'T TOUNCH

  //
  //Change to your app store id
  static String appStoreId = "";

  //
  //saving
  static Future<bool> saveAppSettingsToLocalStorage(String colorsMap) async {
    return await LocalStorageService.prefs
        .setString(AppStrings.appRemoteSettings, colorsMap);
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
}
