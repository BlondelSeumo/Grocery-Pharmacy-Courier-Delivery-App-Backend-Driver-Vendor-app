import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/translations/validator.i18n.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:inspection/inspection.dart';

class FormValidator {
  //For name form validation
  static String validateName(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Invalid name'.i18n;
    }
    return null;
  }

  //For email address form validation
  static String validateEmail(String value) {
    if (value.isEmpty || !EmailUtils.isEmail(value)) {
      return 'Invalid email address'.i18n;
    }
    return null;
  }

  //For email address form validation
  static String validatePhone(String value, {String name}) {
    return Inspection().inspect(
      value,
      'required|numeric|min:3|max:16',
      name: name,
      locale: I18n.localeStr,
    );
  }

  //For email address form validation
  static String validatePassword(String value) {
    if (value.isEmpty || value.trim().isEmpty || value.length < 6) {
      return 'Password must be more than 6 character'.i18n;
    }
    return null;
  }

  static String validateEmpty(String value, {String errorTitle}) {
    if (value.isEmpty || value.trim().isEmpty) {
      return '%s is empty'.i18n.fill(["$errorTitle"]);
    }
    return null;
  }

  static String validateDeliveryAddress(
    String value, {
    String errorTitle,
    @required DeliveryAddress deliveryaddress,
    @required Vendor vendor,
  }) {
    print("Here");
    //
    final validation = validateEmpty(value, errorTitle: errorTitle);
    if (validation != null) {
      return validation;
    }

    //cities,states & countries
    if (vendor.countries != null) {
      final foundCountry = vendor.countries.firstWhere(
        (element) =>
            element.toLowerCase() == "${deliveryaddress.country}".toLowerCase(),
        orElse: () => null,
      );

      //
      if (foundCountry != null) {
        return null;
      }
    }


    //states
    if (vendor.states != null) {
      final foundState = vendor.states.firstWhere(
        (element) =>
            element.toLowerCase() == "${deliveryaddress.state}".toLowerCase(),
        orElse: () => null,
      );

      //
      if (foundState != null) {
        return null;
      }
    }



    //cities
    if (vendor.cities != null) {
      final foundCity = vendor.cities.firstWhere(
        (element) =>
            element.toLowerCase() == deliveryaddress.city.toLowerCase(),
        orElse: () => null,
      );

      //
      if (foundCity != null) {
        return null;
      }
    }
    return "Vendor does not service selected location";
  }

  static String validateCustom(String value,
      {String name, String rules = "required"}) {
    return Inspection().inspect(
      value,
      rules,
      name: name,
      locale: I18n.localeStr,
    );
  }
}
