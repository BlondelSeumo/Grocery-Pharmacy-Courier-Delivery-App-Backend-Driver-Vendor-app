import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/requests/vendor.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor_rating.i18n.dart';

class DriverRatingViewModel extends MyBaseViewModel {
  //
  VendorRequest vendorRequest = VendorRequest();
  Order order;
  Function onSubmitted;
  int rating = 1;
  TextEditingController reviewTEC = TextEditingController();

  //
  DriverRatingViewModel(BuildContext context, this.order, this.onSubmitted) {
    this.viewContext = context;
  }

  void updateRating(String value) {
    rating = double.parse(value).ceil();
  }

  submitRating() async {
    setBusy(true);
    //
    final apiResponse = await vendorRequest.rateDriver(
      rating: rating,
      review: reviewTEC.text,
      orderId: order.id,
      driverId: order.driverId,
    );
    setBusy(false);

    //
    CoolAlert.show(
      context: viewContext,
      type: apiResponse.allGood ? CoolAlertType.success : CoolAlertType.error,
      title: "Driver Rating".i18n,
      text: apiResponse.message,
      onConfirmBtnTap: apiResponse.allGood
          ? () {
              //
              viewContext.pop();
              //
              onSubmitted();
            }
          : null,
    );
  }
}
