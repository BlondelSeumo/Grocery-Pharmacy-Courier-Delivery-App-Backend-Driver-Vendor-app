import 'package:firebase_chat/models/chat_entity.dart';
import 'package:firebase_chat/models/peer_user.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/requests/order.request.dart';
import 'package:fuodz/view_models/payment.view_model.dart';
import 'package:fuodz/widgets/bottomsheets/driver_rating.bottomsheet.dart';
import 'package:fuodz/widgets/bottomsheets/order_cancellation.bottomsheet.dart';
import 'package:fuodz/widgets/bottomsheets/vendor_rating.bottomsheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDetailsViewModel extends PaymentViewModel {
  //
  Order order;
  OrderRequest orderRequest = OrderRequest();

  //
  OrderDetailsViewModel(BuildContext context, this.order) {
    this.viewContext = context;
  }

  initialise() {
    fetchOrderDetails();
  }

  void callVendor() {
    launch("tel:${order.vendor.phone}");
  }

  void callDriver() {
    launch("tel:${order.driver.phone}");
  }

  void callRecipient() {
    launch("tel:${order.recipientPhone}");
  }

  chatVendor() {
    //
    Map<String, PeerUser> peers = {
      '${order.userId}': PeerUser(
        id: '${order.userId}',
        name: order.user.name,
        image: order.user.photo,
      ),
      'vendor_${order.vendor.id}': PeerUser(
        id: "vendor_${order.vendor.id}",
        name: order.vendor.name,
        image: order.vendor.logo,
      ),
    };
    //
    final chatEntity = ChatEntity(
      mainUser: peers['${order.userId}'],
      peers: peers,
      //don't translate this
      path: 'orders/' + order.code + "/customerVendor/chats",
      title: "Chat with vendor".i18n,
    );
    //
    viewContext.navigator.pushNamed(
      AppRoutes.chatRoute,
      arguments: chatEntity,
    );
  }

  chatDriver() {
    //
    Map<String, PeerUser> peers = {
      '${order.userId}': PeerUser(
        id: '${order.userId}',
        name: order.user.name,
        image: order.user.photo,
      ),
      '${order.driver.id}': PeerUser(
          id: "${order.driver.id}",
          name: order.driver.name,
          image: order.driver.photo),
    };
    //
    final chatEntity = ChatEntity(
      mainUser: peers['${order.userId}'],
      peers: peers,
      //don't translate this
      path: 'orders/' + order.code + "/customerDriver/chats",
      title: "Chat with driver".i18n,
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

  refreshDataSet() {
    fetchOrderDetails();
  }

  //
  rateVendor() async {
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      builder: (context) {
        return VendorRatingBottomSheet(
          order: order,
          onSubmitted: () {
            //
            viewContext.pop();
            fetchOrderDetails();
          },
        );
      },
    );
  }

  //
  rateDriver() async {
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      builder: (context) {
        return DriverRatingBottomSheet(
          order: order,
          onSubmitted: () {
            //
            viewContext.pop();
            fetchOrderDetails();
          },
        );
      },
    );
  }

  //
  trackOrder() {
    viewContext.navigator
        .pushNamed(AppRoutes.orderTrackingRoute, arguments: order);
  }

  cancelOrder() async {
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      builder: (context) {
        return OrderCancellationBottomSheet(
          onSubmit: (String reason) {
            viewContext.pop();
            processOrderCancellation(reason);
          },
        );
      },
    );
  }

  //
  processOrderCancellation(String reason) async {
    setBusyForObject(order, true);
    try {
      final responseMessage = await orderRequest.updateOrder(
        id: order.id,
        status: "cancelled",
        reason: reason,
      );
      //
      order.status = "cancelled";
      //message
      viewContext.showToast(
        msg: responseMessage,
        bgColor: Colors.green,
        textColor: Colors.white,
      );

      clearErrors();
    } catch (error) {
      print("Error ==> $error");
      setError(error);
      viewContext.showToast(
        msg: "$error",
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
    setBusyForObject(order, false);
  }

  void showVerificationQRCode() async {
    showDialog(
      context: viewContext,
      builder: (context) {
        return Dialog(
          child: VStack(
            [
              QrImage(
                data: order.verificationCode,
                version: QrVersions.auto,
                size: viewContext.percentWidth * 40,
              ).box.makeCentered(),
              "Verification Code".i18n.text.medium.xl2.makeCentered().py8(),
            ],
          ).p20(),
        );
      },
    );
  }


}
