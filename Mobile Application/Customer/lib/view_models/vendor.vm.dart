import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/user.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:fuodz/translations/dialogs.i18n.dart';

class VendorViewModel extends MyBaseViewModel {
  //
  VendorViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  User currentUser;
  StreamSubscription currentLocationChangeStream;

  //
  int queryPage = 1;

  RefreshController refreshController = RefreshController();

  void initialise() async {
    //
    if (AuthServices.authenticated()) {
      currentUser = await AuthServices.getCurrentUser(force: true);
      notifyListeners();
    }

    //listen to user location change
    currentLocationChangeStream =
        LocationService.currenctAddressSubject.stream.listen(
      (location) {
        //

        deliveryaddress.address = location.addressLine;
        deliveryaddress.latitude = location.coordinates.latitude;
        deliveryaddress.longitude = location.coordinates.longitude;
        notifyListeners();
      },
    );
  }

  //switch to use current location instead of selected delivery address
  void useUserLocation() {
    LocationService.geocodeCurrentLocation();
  }

  //
  dispose() {
    super.dispose();
    currentLocationChangeStream.cancel();
  }

  //
  openSearch() async {
    viewContext.navigator.pushNamed(
      AppRoutes.search,
    );
  }
}
