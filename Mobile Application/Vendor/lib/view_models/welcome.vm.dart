import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class WelcomeViewModel extends MyBaseViewModel {
  //
  WelcomeViewModel(BuildContext context) {
    this.viewContext = context;
  }

  int selectedPage = 0;
  String pageTitle = "";

  pageSelected(int page, String title) {
    if (page == 1 && !AuthServices.authenticated()) {
      viewContext.navigator.pushNamed(AppRoutes.loginRoute);
    } else {
      selectedPage = page;
      pageTitle = title;
      notifyListeners();
    }
  }
}
