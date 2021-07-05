// import 'package:velocity_x/velocity_x.dart';

class Api {
  static String get baseUrl {
    return "https://fuodz.thesnaptask.com/api";
    // return "http://192.168.8.145:8000/api";
  }

  static const appSettings = "/app/settings";

  static const login = "/login";
  static const logout = "/logout";
  static const forgotPassword = "/password/reset/init";
  static const verifyPhoneAccount = "/verify/phone";
  static const updateProfile = "/profile/update";
  static const updatePassword = "/profile/password/update";

  static const orders = "/orders";
  static const chat = "/chat/notification";
  static const users = "/users";
  static const products = "/products";
  static const productCategories = "/categories";
  static const packagePricing = "/vendor/package/pricing";
  static const packageTypes = "/package/types";

  //
  static const vendorDetails = "/vendor/id/details";

  // Other pages
  static String get privacyPolicy {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/privacy/policy";
  }
}
