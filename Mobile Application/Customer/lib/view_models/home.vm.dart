import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/services/local_storage.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class HomeViewModel extends MyBaseViewModel {
  //
  HomeViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  int currentIndex = 0;
  PageController pageViewController = PageController(initialPage: 0);
  int totalCartItems = 0;
  StreamSubscription homePageChangeStream;

  @override
  void initialise() async {
    //
    //start listening to changes to items in cart
    LocalStorageService.rxPrefs.getIntStream(CartServices.totalItemKey).listen(
      (total) {
        if (total != null) {
          totalCartItems = total;
          notifyListeners();
        }
      },
    );

    //
    homePageChangeStream = AppService.homePageIndex.stream.listen(
      (index) {
        //
        onTabChange(index);
      },
    );
  }

  //
  dispose() {
    super.dispose();
    homePageChangeStream.cancel();
  }

  //
  onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  //
  onTabChange(int index) {
    currentIndex = index;
    pageViewController.animateToPage(
      currentIndex,
      duration: Duration(microseconds: 5),
      curve: Curves.bounceInOut,
    );
    notifyListeners();
  }


}
