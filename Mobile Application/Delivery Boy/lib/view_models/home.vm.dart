import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/new_order.dart';
import 'package:fuodz/models/user.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/local_storage.service.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/widgets/bottomsheets/new_order_alert.bottomsheet.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:georange/georange.dart';
import 'package:fuodz/translations/home.i18n.dart';

class HomeViewModel extends MyBaseViewModel {
  //
  HomeViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  // bool isOnline = true;
  int currentIndex = 0;
  User currentUser;
  PageController pageViewController = PageController(initialPage: 0);
  int totalCartItems = 0;
  StreamSubscription homePageChangeStream;
  StreamSubscription locationReadyStream;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  GeoRange georange = GeoRange();
  bool canAcceptNewOrder = true;
  StreamSubscription newOrderStream;

  AuthRequest authRequest = AuthRequest();

  @override
  void initialise() async {
    //
    currentUser = await AuthServices.getCurrentUser();
    //
    AppService.driverIsOnline =
        LocalStorageService.prefs.getBool(AppStrings.onlineOnApp) ?? false;
    notifyListeners();

    //
    locationReadyStream =
        LocationService.locationDataAvailable.stream.listen((event) {
      if (event) {
        listenToNewOrders();
      }
    });

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
    cancelAllListeners();
  }

  cancelAllListeners() async {
    homePageChangeStream.cancel();
    if (newOrderStream != null) {
      newOrderStream.cancel();
    }
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

  void toggleOnlineStatus() async {
    setBusy(true);
    try {
      //
      final apiResponse =
          await authRequest.updateProfile(isOnline: !AppService.driverIsOnline);
      if (apiResponse.allGood) {
        //
        AppService.driverIsOnline = !AppService.driverIsOnline;
        await LocalStorageService.prefs
            .setBool(AppStrings.onlineOnApp, AppService.driverIsOnline);
        //
        viewContext.showToast(
          msg: "Updated Successfully".i18n,
          bgColor: Colors.green,
        );

        //
        if (AppService.driverIsOnline) {
          listenToNewOrders();
        } else {
          cancelAllListeners();
        }
      } else {
        viewContext.showToast(
          msg: "${apiResponse.message}",
          bgColor: Colors.red,
        );
      }
    } catch (error) {
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
    setBusy(false);
  }

  //NEW ORDER STREAM

  listenToNewOrders() async {
    //
    newOrderStream =
        firebaseFirestore.collection("newOrders").snapshots().listen(
      ((querySnapshot) {
        if (querySnapshot.docChanges.length > 0) {
          final latestDocChange = querySnapshot.docChanges.first;
          final newOrder = NewOrder.fromJson(latestDocChange.doc.data());
          // Do something with change

          //
          if (AppService.driverIsOnline) {
            Point pickupPoint = Point(
              latitude: newOrder.pickup.lat,
              longitude: newOrder.pickup.long,
            );
            Point dropoffPoint = Point(
              latitude: newOrder.dropoff.lat,
              longitude: newOrder.dropoff.long,
            );
            //
            Point driverLocation = Point(
              latitude: LocationService.currentLocation.latitude,
              longitude: LocationService.currentLocation.longitude,
            );

            //
            var distance = georange.distance(pickupPoint, driverLocation);
            newOrder.distance = distance;
            var orderDistance = georange.distance(pickupPoint, dropoffPoint);
            newOrder.orderDistance = orderDistance;
            //check if can accpet new parcel order
            bool acceptParcelOrder = canAcceptNewParcelOrder(newOrder);
            //check if driver is within delivery range
            bool acceptRegularOrder = canAcceptNewRegularOrder(
              newOrder,
              distance,
            );

            //
            if (acceptParcelOrder || acceptRegularOrder) {
              if (currentUser.vendorId == null ||
                  newOrder.vendorId == currentUser.vendorId) {
                showNewOrderAlert(newOrder);
              }
            }
          }
        }
      }),
    );
  }

  void showNewOrderAlert(NewOrder newOrder) async {
    canAcceptNewOrder = false;
    //
    final result = await showModalBottomSheet(
      context: AppService.navigatorKey.currentContext,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return NewOrderAlertBottomSheet(newOrder);
      },
    );
    //
    canAcceptNewOrder = true;

    //
    if (result is bool && result) {
      AppService.refreshAssignedOrders.add(true);
    }
  }

  //getters
  bool canAcceptNewParcelOrder(NewOrder newOrder) {
    print("My city ==> ${LocationService.currentLocation.city}");
    print("Order city ==> ${newOrder.pickup.city}");
    return newOrder.isParcel &&
        newOrder.pickup.city.toLowerCase() ==
            LocationService.currentLocation.city.toLowerCase() &&
        canAcceptNewOrder;
  }

  bool canAcceptNewRegularOrder(NewOrder newOrder, double distance) {
    return distance <= newOrder.range && canAcceptNewOrder;
  }
}
