import 'package:firebase_chat/models/chat_entity.dart';
import 'package:firebase_chat/models/peer_user.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/requests/order.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/views/pages/order/widgets/scanner_verification_dialog.dart';
import 'package:fuodz/views/pages/order/widgets/verification_dialog.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderDetailsViewModel extends MyBaseViewModel {
  //
  Order order;
  OrderRequest orderRequest = OrderRequest();
  bool changed = false;

  //
  OrderDetailsViewModel(BuildContext context, this.order) {
    this.viewContext = context;
  }

  initialise() {
    fetchOrderDetails();
  }

  openPaymentPage() {
    launch(order.paymentLink);
  }

  void callVendor() {
    launch("tel:${order.vendor.phone}");
  }

  void callCustomer() {
    launch("tel:${order.user.phone}");
  }

  void callRecipient() {
    launch("tel:${order.recipientPhone}");
  }

  chatVendor() {
    //
    Map<String, PeerUser> peers = {
      '${order.driver.id}': PeerUser(
        id: '${order.driver.id}',
        name: order.driver.name,
        image: order.driver.photo,
      ),
      'vendor_${order.vendor.id}': PeerUser(
        id: "vendor_${order.vendor.id}",
        name: order.vendor.name,
        image: order.vendor.logo,
      ),
    };
    //
    final chatEntity = ChatEntity(
      mainUser: peers['${order.driver.id}'],
      peers: peers,
      //don't translate this
      path: 'orders/' + order.code + "/driverVendor/chats",
      title: "Chat with vendor".i18n,
    );
    //
    viewContext.navigator.pushNamed(
      AppRoutes.chatRoute,
      arguments: chatEntity,
    );
  }

  chatCustomer() {
    //
    Map<String, PeerUser> peers = {
      '${order.driver.id}': PeerUser(
        id: '${order.driver.id}',
        name: order.driver.name,
        image: order.driver.photo,
      ),
      '${order.user.id}': PeerUser(
          id: "${order.user.id}",
          name: order.user.name,
          image: order.user.photo),
    };
    //
    final chatEntity = ChatEntity(
      mainUser: peers['${order.driver.id}'],
      peers: peers,
      //don't translate this
      path: 'orders/' + order.code + "/customerDriver/chats",
      title: "Chat with customer".i18n,
    );
    //
    viewContext.navigator.pushNamed(
      AppRoutes.chatRoute,
      arguments: chatEntity,
    );
  }

  void fetchOrderDetails() async {
    setBusy(true);
    try {
      order = await orderRequest.getOrderDetails(id: order.id);
      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      viewContext.showToast(
        msg: "$error",
        bgColor: Colors.red,
      );
    }
    setBusy(false);
  }

  //
  void initiateOrderCompletion() async {
    if (AppStrings.enableProofOfDelivery) {
      showModalBottomSheet(
        context: AppService.navigatorKey.currentContext,
        isScrollControlled: true,
        builder: (context) {
          return OrderVerificationDialog(
            order: order,
            onValidated: () {
              AppService.navigatorKey.currentContext.pop();
              processOrderCompletion();
            },
            openQRCodeScanner: () {
              AppService.navigatorKey.currentContext.pop();
              showQRCodeScanner();
            },
          );
        },
      );
    } else {
      processOrderCompletion();
    }
  }

  //
  showQRCodeScanner() async {
    showDialog(
      context: AppService.navigatorKey.currentContext,
      builder: (context) {
        return Dialog(
          child: ScanOrderVerificationDialog(
            order: order,
            onValidated: () {
              // AppService.navigatorKey.currentContext.pop();
              processOrderCompletion();
            },
          ),
        );
      },
    );
  }

  void processOrderCompletion() async {
    setBusyForObject(order, true);
    try {
      order = await orderRequest.updateOrder(
        id: order.id,
        status: "delivered",
      );
      //beaware a change as occurred
      changed = true;
      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setErrorForObject(order, error);
      viewContext.showToast(
        msg: "$error",
        bgColor: Colors.red,
      );
    }
    setBusyForObject(order, false);
  }

  //
  void processOrderEnroute() async {
    setBusyForObject(order, true);
    try {
      order = await orderRequest.updateOrder(
        id: order.id,
        status: "enroute",
      );
      //beaware a change as occurred
      changed = true;
      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setErrorForObject(order, error);
      viewContext.showToast(
        msg: "$error",
        bgColor: Colors.red,
      );
    }
    setBusyForObject(order, false);
  }

  onBackPressed() {
    //
    AppService.navigatorKey.currentContext.pop(changed ? true : null);
  }

  //
  routeToLocation(DeliveryAddress deliveryAddress) async {
    try {
      final coords =
          Coords(deliveryAddress.latitude, deliveryAddress.longitude);
      final title = deliveryAddress.name;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: AppService.navigatorKey.currentContext,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
