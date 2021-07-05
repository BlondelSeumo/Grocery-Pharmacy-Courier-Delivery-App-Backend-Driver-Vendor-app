import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppService {
  //
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  //
  static BehaviorSubject<int> homePageIndex = BehaviorSubject<int>();

  //
  static changeHomePageIndex({int index = 2}) async {
    print("Changed Home Page");
    homePageIndex.add(index);
  }
}
