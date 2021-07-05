import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/requests/checkout.request.dart';
import 'package:fuodz/requests/delivery_address.request.dart';
import 'package:fuodz/requests/vendor.request.dart';
import 'package:fuodz/requests/payment_method.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/view_models/payment.view_model.dart';
import 'package:fuodz/widgets/bottomsheets/delivery_address_picker.bottomsheet.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/checkout.i18n.dart';
import 'package:supercharged/supercharged.dart';

class CheckoutViewModel extends PaymentViewModel {
  //
  CheckoutRequest checkoutRequest = CheckoutRequest();
  DeliveryAddressRequest deliveryAddressRequest = DeliveryAddressRequest();
  PaymentMethodRequest paymentOptionRequest = PaymentMethodRequest();

  VendorRequest vendorRequest = VendorRequest();
  TextEditingController driverTipTEC = TextEditingController();
  TextEditingController noteTEC = TextEditingController();
  DeliveryAddress deliveryAddress;
  bool isPickup = false;
  bool isScheduled = false;
  List<String> availableTimeSlots = [];
  bool delievryAddressOutOfRange = false;
  bool canSelectPaymentOption = true;
  Vendor vendor;
  CheckOut checkout;

  //
  List<PaymentMethod> paymentMethods = [];
  PaymentMethod selectedPaymentMethod;

  //
  CheckoutViewModel(BuildContext context, this.checkout) {
    this.viewContext = context;
  }

  void initialise() async {
    await fetchVendorDetails();
    await prefetchDeliveryAddress();
    await fetchPaymentOptions();
  }

  //
  fetchVendorDetails() async {
    //
    vendor = CartServices.productsInCart[0].product.vendor;

    //
    setBusy(true);
    try {
      vendor = await vendorRequest.vendorDetails(vendor.id);
      setVendorRequirement();
    } catch (error) {
      print("Error Getting Vendor Details ==> $error");
    }
    setBusy(false);
  }

  setVendorRequirement() {
    if (vendor.allowOnlyDelivery) {
      isPickup = false;
    } else if (vendor.allowOnlyPickup) {
      isPickup = true;
    }
  }

  //start of schedule related
  changeSelectedDeliveryDate(String string, int index) {
    checkout.deliverySlotDate = string;
    availableTimeSlots = vendor.deliverySlots[index].times;
    notifyListeners();
  }

  changeSelectedDeliveryTime(String time) {
    checkout.deliverySlotTime = time;
    notifyListeners();
  }

  //end of schedule related
  //
  prefetchDeliveryAddress() async {
    setBusyForObject(deliveryAddress, true);
    //
    try {
      //
      checkout.deliveryAddress = deliveryAddress =
          await deliveryAddressRequest.preselectedDeliveryAddress(
        vendorId: vendor.id,
      );

      //
      checkDeliveryRange();
      updateTotalOrderSummary();
    } catch (error) {
      print("Error Fetching preselected Address ==> $error");
    }
    setBusyForObject(deliveryAddress, false);
  }

  //
  fetchPaymentOptions() async {
    setBusyForObject(paymentMethods, true);
    try {
      paymentMethods = await paymentOptionRequest.getPaymentOptions(
        vendorId: vendor.id,
      );
      //
      updatePaymentOptionSelection();
      clearErrors();
    } catch (error) {
      print("Error getting payment methods ==> $error");
    }
    setBusyForObject(paymentMethods, false);
  }

  updatePaymentOptionSelection() {
    if (checkout.total <= 0.00) {
      canSelectPaymentOption = false;
    } else {
      canSelectPaymentOption = true;
    }
    //
    if (!canSelectPaymentOption) {
      final selectedPaymentMethod = paymentMethods.firstWhere(
        (e) => e.isCash == 1,
        orElse: () => null,
      );
      if (selectedPaymentMethod != null) {
        changeSelectedPaymentMethod(selectedPaymentMethod);
      }
    }
  }

  //
  showDeliveryAddressPicker() async {
    //
    await showModalBottomSheet(
      context: viewContext,
      builder: (context) {
        return DeliveryAddressPicker(
          onSelectDeliveryAddress: (deliveryAddress) {
            this.deliveryAddress = deliveryAddress;
            checkout.deliveryAddress = deliveryAddress;
            //
            checkDeliveryRange();
            updateTotalOrderSummary();
            //
            notifyListeners();
            viewContext.pop();
          },
        );
      },
    );
    return null;
  }

  //
  togglePickupStatus(bool value) {
    //
    if (vendor.allowOnlyPickup) {
      value = true;
    } else if (vendor.allowOnlyDelivery) {
      value = false;
    }
    isPickup = value;
    //remove delivery address if pickup
    if (isPickup) {
      checkout.deliveryAddress = null;
    } else {
      checkout.deliveryAddress = deliveryAddress;
    }

    updateTotalOrderSummary();
    notifyListeners();
  }

  //
  toggleScheduledOrder(bool value) {
    isScheduled = value;
    checkout.isScheduled = isScheduled;
    //remove delivery address if pickup
    checkout.pickupDate = null;
    checkout.deliverySlotDate = "";
    checkout.pickupTime = null;
    checkout.deliverySlotTime = "";

    notifyListeners();
  }

  //
  void checkDeliveryRange() {
    delievryAddressOutOfRange =
        vendor.deliveryRange < (deliveryAddress.distance ?? 0);
    notifyListeners();
  }

  //
  isSelected(PaymentMethod paymentMethod) {
    return selectedPaymentMethod != null &&
        paymentMethod.id == selectedPaymentMethod.id;
  }

  changeSelectedPaymentMethod(PaymentMethod paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    checkout.paymentMethod = paymentMethod;
    updateTotalOrderSummary();
    notifyListeners();
  }

  //update total/order amount summary
  updateTotalOrderSummary() async {
    //delivery fee
    if (!isPickup && deliveryAddress != null) {
      //selected delivery address is within range
      if (!delievryAddressOutOfRange) {
        //vendor charges per km
        if (vendor.chargePerKm != null && vendor.chargePerKm == 1) {
          checkout.deliveryFee = vendor.deliveryFee * deliveryAddress.distance;
        } else {
          checkout.deliveryFee = vendor.deliveryFee;
        }

        //adding base fee
        checkout.deliveryFee += vendor.baseDeliveryFee;
      } else {
        checkout.deliveryFee = 0.00;
      }
    } else {
      checkout.deliveryFee = 0.00;
    }

    //tax
    checkout.tax = (double.parse(vendor.tax) / 100) * checkout.subTotal;
    checkout.total = (checkout.subTotal - checkout.discount) +
        checkout.deliveryFee +
        checkout.tax;

    //
    updatePaymentOptionSelection();
    notifyListeners();
  }

  //
  bool pickupOnlyProduct() {
    //
    final product = CartServices.productsInCart.firstWhere(
      (e) => !e.product.canBeDelivered,
      orElse: () => null,
    );

    return product != null;
  }

  //
  updateCheckoutTotalAmount() {
    checkout.totalWithTip = checkout.total + driverTipTEC.text.toDouble();
  }

  //
  placeOrder() async {
    if (isScheduled && checkout.deliverySlotDate.isEmptyOrNull) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Delivery Date".i18n,
        text: "Please select your desire order date".i18n,
      );
    } else if (isScheduled && checkout.deliverySlotTime.isEmptyOrNull) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Delivery Time".i18n,
        text: "Please select your desire order time".i18n,
      );
    } else if (!isPickup && pickupOnlyProduct()) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Product".i18n,
        text:
            "There seems to be products that can not be delivered in your cart"
                .i18n,
      );
    } else if (!isPickup && deliveryAddress == null) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Delivery address".i18n,
        text: "Please select delivery address".i18n,
      );
    } else if (delievryAddressOutOfRange && !isPickup) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Delivery address".i18n,
        text: "Delivery address is out of vendor delivery range".i18n,
      );
    } else if (selectedPaymentMethod == null) {
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Payment Methods".i18n,
        text: "Please select a payment method".i18n,
      );
    }
    //process the new order
    else {
      setBusy(true);
      //set the total with discount as the new total
      checkout.total = checkout.totalWithTip;
      //
      final apiResponse = await checkoutRequest.newOrder(
        checkout,
        tip: driverTipTEC.text,
        note: noteTEC.text,
      );
      //not error
      if (apiResponse.allGood) {
        //cash payment

        final paymentLink = apiResponse.body["link"].toString();
        if (!paymentLink.isEmptyOrNull) {
          viewContext.pop();
          showOrdersTab();
          openWebpageLink(paymentLink);
        }
        //cash payment
        else {
          CoolAlert.show(
              context: viewContext,
              type: CoolAlertType.success,
              title: "Checkout".i18n,
              text: apiResponse.message,
              barrierDismissible: false,
              onConfirmBtnTap: () {
                showOrdersTab();
                viewContext.pop();
                if (viewContext.navigator.canPop()) {
                  viewContext.pop();
                }
              });
        }
      } else {
        CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Checkout".i18n,
          text: apiResponse.message,
        );
      }
      setBusy(false);
    }
  }

  //
  showOrdersTab() {
    //clear cart items
    CartServices.clearCart();
    //switch tab to orders
    AppService.changeHomePageIndex(index: 1);
  }
}
