// import 'package:velocity_x/velocity_x.dart';

class Api {
 
  static String get baseUrl {
    return "https://fuodz.thesnaptask.com/api";
    // return "http://192.168.8.145:8000/api";
  }

  static const appSettings = "/app/settings";

  static const login = "/login";
  static const register = "/register";
  static const logout = "/logout";
  static const forgotPassword = "/password/reset/init";
  static const verifyPhoneAccount = "/verify/phone";
  static const updateProfile = "/profile/update";
  static const updatePassword = "/profile/password/update";

  //
  static const banners = "/banners";
  static const categories = "/categories";
  static const products = "/products";
  static const bestProducts = "/products?type=best";
  static const forYouProducts = "/products?type=you";
  static const vendors = "/vendors";
  static const topVendors = "/vendors?type=top";
  static const bestVendors = "/vendors?type=best";

  static const search = "/search";
  static const favourites = "/favourites";


  //cart & checkout
  static const coupons = "/coupons";
  static const deliveryAddresses = "/delivery/addresses";
  static const paymentMethods = "/payment/methods";
  static const orders = "/orders";
  static const packageOrders = "/package/orders";
  static const packageOrderSummary = "/package/order/summary";
  static const chat = "/chat/notification";
  static const rating = "/rating";

  //packages
  static const packageTypes = "/package/types";
  //wallet
  static const walletBalance = "/wallet/balance";
  static const walletTopUp = "/wallet/topup";

  // Other pages
  static String get privacyPolicy {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/privacy/policy";
  }
}
