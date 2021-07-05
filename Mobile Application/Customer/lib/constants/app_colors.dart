import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/local_storage.service.dart';
import 'package:velocity_x/velocity_x.dart';

class AppColor {
  static Color get accentColor => Vx.hexToColor(colorEnv('accentColor'));
  static Color get primaryColor => Vx.hexToColor(colorEnv('primaryColor'));
  static Color get primaryColorDark =>
      Vx.hexToColor(colorEnv('primaryColorDark'));
  static Color get cursorColor => accentColor;

  //onboarding colors
  static Color get onboarding1Color =>
      Vx.hexToColor(colorEnv('onboarding1Color'));
  static Color get onboarding2Color =>
      Vx.hexToColor(colorEnv('onboarding2Color'));
  static Color get onboarding3Color =>
      Vx.hexToColor(colorEnv('onboarding3Color'));

  static Color get onboardingIndicatorDotColor =>
      Vx.hexToColor(colorEnv('onboardingIndicatorDotColor'));
  static Color get onboardingIndicatorActiveDotColor =>
      Vx.hexToColor(colorEnv('onboardingIndicatorActiveDotColor'));

  //Shimmer Colors
  static Color shimmerBaseColor = Colors.grey[300];
  static Color shimmerHighlightColor = Colors.grey[200];

  //inputs
  static Color get inputFillColor => Colors.grey[200];
  static Color get iconHintColor => Colors.grey[500];

  static Color get openColor => Vx.hexToColor(colorEnv('openColor'));
  static Color get closeColor => Vx.hexToColor(colorEnv('closeColor'));
  static Color get deliveryColor => Vx.hexToColor(colorEnv('deliveryColor'));
  static Color get pickupColor => Vx.hexToColor(colorEnv('pickupColor'));
  static Color get ratingColor => Vx.hexToColor(colorEnv('ratingColor'));

  static Color getStausColor(String status) {
    //'pending','preparing','enroute','failed','cancelled','delivered'
    switch (status) {
      case "pending":
        return Vx.hexToColor(colorEnv('pendingColor'));
        break;
      case "preparing":
        return Vx.hexToColor(colorEnv('preparingColor'));
        break;
      case "enroute":
        return Vx.hexToColor(colorEnv('enrouteColor'));
        break;
      case "failed":
        return Vx.hexToColor(colorEnv('failedColor'));
        break;
      case "cancelled":
        return Vx.hexToColor(colorEnv('cancelledColor'));
        break;
      case "delivered":
        return Vx.hexToColor(colorEnv('deliveredColor'));
      case "successful":
        return Vx.hexToColor(colorEnv('successfulColor'));
        break;
      default:
        return Vx.hexToColor(colorEnv('pendingColor'));
    }
  }

  //saving
  static Future<bool> saveColorsToLocalStorage(String colorsMap) async {
    return await LocalStorageService.prefs
        .setString(AppStrings.appColors, colorsMap);
  }

  static dynamic appColorsObject;
  static Future<void> getColorsFromLocalStorage() async {
    appColorsObject = LocalStorageService.prefs.getString(AppStrings.appColors);
    if (appColorsObject != null) {
      appColorsObject = jsonDecode(appColorsObject);
    }
  }

  static String colorEnv(String colorRef) {

    //
    getColorsFromLocalStorage();
    //
    final selectedColor =
        appColorsObject != null ? appColorsObject[colorRef] : "#000000";
    return selectedColor;
  }
}
