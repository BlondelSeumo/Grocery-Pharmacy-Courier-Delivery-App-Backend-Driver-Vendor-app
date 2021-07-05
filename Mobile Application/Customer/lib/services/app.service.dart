import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart' as intl;

class AppService {
  //
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  //
  static BehaviorSubject<int> homePageIndex = BehaviorSubject<int>();

  //
  static changeHomePageIndex({int index = 2}) async {
    print("Changed Home Page");
    homePageIndex.add(index);
  }

  static bool isDirectionRTL(BuildContext context) {
    return intl.Bidi.isRtlLanguage(I18n.localeStr);
  }
}
