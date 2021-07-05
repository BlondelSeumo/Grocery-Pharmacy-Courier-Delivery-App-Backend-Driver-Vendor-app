import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/requests/delivery_address.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/delivery_address/delivery_addresses.i18n.dart';

class DeliveryAddressesViewModel extends MyBaseViewModel {
  //
  DeliveryAddressRequest deliveryAddressRequest = DeliveryAddressRequest();
  List<DeliveryAddress> deliveryAddresses = [];

  //
  DeliveryAddressesViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  void initialise() {
    //
    fetchDeliveryAddresses();
  }

  //
  fetchDeliveryAddresses() async {
    //
    setBusyForObject(deliveryAddresses, true);
    try {
      deliveryAddresses = await deliveryAddressRequest.getDeliveryAddresses();
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusyForObject(deliveryAddresses, false);
  }

  //
  newDeliveryAddressPressed() async {
    await viewContext.navigator.pushNamed(
      AppRoutes.newDeliveryAddressesRoute,
    );
    fetchDeliveryAddresses();
  }

  //
  editDeliveryAddress(DeliveryAddress deliveryAddress) async {
    await viewContext.navigator.pushNamed(
      AppRoutes.editDeliveryAddressesRoute,
      arguments: deliveryAddress,
    );
    fetchDeliveryAddresses();
  }

  //
  deleteDeliveryAddress(DeliveryAddress deliveryAddress) {
    //
    CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.confirm,
        title: "Delete Delivery Address".i18n,
        text: "Are you sure you want to delete this delivery address?".i18n,
        confirmBtnText: "Delete".i18n,
        onConfirmBtnTap: () {
          viewContext.pop();
          processDeliveryAddressDeletion(deliveryAddress);
        });
  }

  //
  processDeliveryAddressDeletion(DeliveryAddress deliveryAddress) async {
    setBusy(true);
    //
    final apiResponse = await deliveryAddressRequest.deleteDeliveryAddress(
      deliveryAddress,
    );

    //remove from list
    if (apiResponse.allGood) {
      deliveryAddresses.remove(deliveryAddress);
    }

    setBusy(false);

    CoolAlert.show(
      context: viewContext,
      type: apiResponse.allGood ? CoolAlertType.success : CoolAlertType.error,
      title: "Delete Delivery Address".i18n,
      text: apiResponse.message,
    );
  }
}
