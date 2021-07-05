import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_chat/models/chat_entity.dart';
import 'package:firebase_chat/models/peer_user.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/requests/order.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/widgets/bottomsheets/assign_order.bottomsheet.dart';
import 'package:fuodz/widgets/bottomsheets/order_edit_status.bottomsheet.dart';
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

  void callDriver() {
    launch("tel:${order.driver.phone}");
  }

  void callCustomer() {
    launch("tel:${order.user.phone}");
  }

  void callRecipient() {
    launch("tel:${order.recipientPhone}");
  }

  chatDriver() {
    //
    Map<String, PeerUser> peers = {
      'vendor_${order.vendor.id}': PeerUser(
        id: "vendor_${order.vendor.id}",
        name: order.vendor.name,
        image: order.vendor.logo,
      ),
      '${order.driverId}': PeerUser(
        id: '${order.driverId}',
        name: order.driver.name,
        image: order.driver.photo,
      ),
    };
    //
    final chatEntity = ChatEntity(
      mainUser: peers['vendor_${order.vendor.id}'],
      peers: peers,
      //don't translate this
      path: 'orders/' + order.code + "/driverVendor/chats",
      title: "Chat with driver".i18n,
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
      'vendor_${order.vendor.id}': PeerUser(
        id: "vendor_${order.vendor.id}",
        name: order.vendor.name,
        image: order.vendor.logo,
      ),
      '${order.userId}': PeerUser(
        id: '${order.userId}',
        name: order.user.name,
        image: order.user.photo,
      ),
    };
    //
    final chatEntity = ChatEntity(
      mainUser: peers['vendor_${order.vendor.id}'],
      peers: peers,
      //don't translate this
      path: 'orders/' + order.code + "/customerVendor/chats",
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

  //Cancel order
  void processOrderCancellation() async {
    //
    CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.confirm,
        title: "Order Status".i18n,
        text:
            "You are about to change this order status to %s. Do you want to continue?"
                .i18n
                .fill(["cancelled".i18n]),
        cancelBtnText: "No".i18n,
        confirmBtnText: "Yes".i18n,
        onConfirmBtnTap: () {
          viewContext.pop();
          processCancellation();
        });
  }

  processCancellation() async {
    setBusyForObject(order, true);
    try {
      order = await orderRequest.updateOrder(
        id: order.id,
        status: "cancelled",
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

  //Edit status
  void changeOrderStatus() async {
    showModalBottomSheet(
      context: viewContext,
      builder: (context) {
        return OrderEditStatusBottomSheet(
          onConfirm: (value) {
            viewContext.pop();
            processStatusUpdate(value);
          },
        );
      },
    );
  }

  processStatusUpdate(String value) async {
    setBusyForObject(order, true);
    try {
      order = await orderRequest.updateOrder(
        id: order.id,
        status: value,
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



   //Assign order
  void assignOrder() async {
    showModalBottomSheet(
      context: viewContext,
      builder: (context) {
        return AssignOrderBottomSheet(
          onConfirm: (value) {
            viewContext.pop();
            processDriverAssignment(value);
          },
        );
      },
    );
  }

   processDriverAssignment(int driverId) async {
    setBusyForObject(order, true);
    try {
      order = await orderRequest.assignOrderToDriver(
        id: order.id,
        driverId: driverId,
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
