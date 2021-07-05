import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/package_checkout.dart';
import 'package:fuodz/models/package_type.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/requests/checkout.request.dart';
import 'package:fuodz/requests/package.request.dart';
import 'package:fuodz/requests/payment_method.request.dart';
import 'package:fuodz/requests/vendor.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/view_models/payment.view_model.dart';
import 'package:jiffy/jiffy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/checkout.i18n.dart';

class NewParcelViewModel extends PaymentViewModel {
  //
  PackageRequest packageRequest = PackageRequest();
  VendorRequest vendorRequest = VendorRequest();
  PaymentMethodRequest paymentOptionRequest = PaymentMethodRequest();
  CheckoutRequest checkoutRequest = CheckoutRequest();
  Function onFinish;

  //Step 1
  List<PackageType> packageTypes = [];
  PackageType selectedPackgeType;

  //Step 2
  List<Vendor> vendors = [];
  Vendor selectedVendor;
  bool requireParcelInfo = true;

  //Step 3
  DeliveryAddress pickupLocation;
  DeliveryAddress dropoffLocation;
  DateTime selectedPickupDate;
  String pickupDate;
  TimeOfDay selectedPickupTime;
  String pickupTime;

  final deliveryInfoFormKey = GlobalKey<FormState>();
  TextEditingController fromTEC = TextEditingController();
  TextEditingController toTEC = TextEditingController();
  List<TextEditingController> toTECs = [];
  TextEditingController dateTEC = TextEditingController();
  TextEditingController timeTEC = TextEditingController();
  bool isScheduled = false;
  List<String> availableTimeSlots = [];

  //step 4
  //receipent
  final recipientInfoFormKey = GlobalKey<FormState>();
  TextEditingController recipientNameTEC = TextEditingController();
  TextEditingController recipientPhoneTEC = TextEditingController();

  //step 5
  final packageInfoFormKey = GlobalKey<FormState>();
  TextEditingController packageWeightTEC = TextEditingController();
  TextEditingController packageHeightTEC = TextEditingController();
  TextEditingController packageWidthTEC = TextEditingController();
  TextEditingController packageLengthTEC = TextEditingController();
  TextEditingController noteTEC = TextEditingController();

  //packageCheckout
  PackageCheckout packageCheckout = PackageCheckout();
  List<PaymentMethod> paymentMethods = [];
  PaymentMethod selectedPaymentMethod;

  //
  int activeStep = 0;
  PageController pageController = PageController();

  //
  NewParcelViewModel(BuildContext context, this.onFinish) {
    this.viewContext = context;
  }

  void initialise() async {
    //
    if (AppStrings.enableParcelMultipleStops) {
      packageCheckout.stopsLocation = [];
      addNewStop();
    }
    await fetchParcelTypes();
    await fetchPaymentOptions();
  }

  //
  fetchParcelTypes() async {
    //
    setBusyForObject(packageTypes, true);
    try {
      packageTypes = await packageRequest.fetchPackageTypes();
      clearErrors();
    } catch (error) {
      setErrorForObject(packageTypes, error);
    }
    setBusyForObject(packageTypes, false);
  }

  fetchParcelVendors() async {
    //
    vendors = [];
    setBusyForObject(vendors, true);
    try {
      vendors = await vendorRequest.fetchParcelVendors(
        packageTypeId: selectedPackgeType.id,
      );

      //
      if (AppStrings.enableSingleVendor) {
        changeSelectedVendor(vendors.first);
      }
      clearErrors();
    } catch (error) {
      setErrorForObject(vendors, error);
    }
    setBusyForObject(vendors, false);
  }

  //
  fetchPaymentOptions() async {
    setBusyForObject(paymentMethods, true);
    try {
      paymentMethods = await paymentOptionRequest.getPaymentOptions();
      clearErrors();
    } catch (error) {
      print("Error getting payment methods ==> $error");
    }
    setBusyForObject(paymentMethods, false);
  }

  ///FORM MANIPULATION
  nextForm(int index) {
    activeStep = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  //
  void changeSelectedPackageType(PackageType packgeType) async {
    selectedPackgeType = packgeType;
    packageCheckout.packageType = selectedPackgeType;
    notifyListeners();
    await fetchParcelVendors();
  }

  changeSelectedVendor(Vendor vendor) {
    selectedVendor = vendor;
    packageCheckout.vendor = selectedVendor;
    final vendorPackagePricing = selectedVendor.packageTypesPricing.firstWhere(
      (e) => e.packageTypeId == selectedPackgeType.id,
      orElse: () => null,
    );

    if (vendorPackagePricing != null) {
      requireParcelInfo = vendorPackagePricing.fieldRequired ?? true;
    }
    notifyListeners();
  }

  //
  changePickupAddress() async {
    final result = await showDeliveryAddressPicker();
    if (result != null) {
      pickupLocation = result;
      fromTEC.text = pickupLocation.address;
      //
      packageCheckout.pickupLocation = pickupLocation;
      notifyListeners();
    }
  }

  //
  changeDropOffAddress() async {
    final result = await showDeliveryAddressPicker();
    if (result != null) {
      dropoffLocation = result;
      toTEC.text = dropoffLocation.address;
      //
      packageCheckout.dropoffLocation = dropoffLocation;
      notifyListeners();
    }
  }

  //
  changeStopDeliveryAddress(int index) async {
    final result = await showDeliveryAddressPicker();
    if (result != null) {
      dropoffLocation = result;
      toTECs[index].text = dropoffLocation.address;
      //
      packageCheckout.stopsLocation[index] = dropoffLocation;
      notifyListeners();
    }
  }

  //
  toggleScheduledOrder(bool value) {
    isScheduled = value;
    packageCheckout.isScheduled = isScheduled;
    //remove delivery address if pickup
    if (isScheduled) {
      packageCheckout.date = null;
      packageCheckout.time = null;
    } else {
      packageCheckout.date = null;
      packageCheckout.time = null;
    }

    notifyListeners();
  }

  //start of schedule related
  changeSelectedDeliveryDate(String string, int index) {
    packageCheckout.deliverySlotDate = string;
    packageCheckout.date = string;
    pickupDate = string;
    availableTimeSlots = selectedVendor.deliverySlots[index].times;
    notifyListeners();
  }

  changeSelectedDeliveryTime(String time) {
    packageCheckout.deliverySlotTime = time;
    packageCheckout.time = time;
    pickupTime = time;
    notifyListeners();
  }

  //
  changeDropOffDate() async {
    final result = await showDatePicker(
      context: viewContext,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(
          days: selectedVendor.packageTypesPricing.first.maxBookingDays ?? 7,
        ),
      ),
      initialDate: selectedPickupDate ?? DateTime.now(),
    );

    //
    if (result != null) {
      selectedPickupDate = result;
      pickupDate =
          Jiffy.unix(result.millisecondsSinceEpoch).format("yyyy-MM-dd");
      dateTEC.text = Jiffy.unix(result.millisecondsSinceEpoch).yMMMMd;
      packageCheckout.date = pickupDate;
      notifyListeners();
    }
  }

  changeDropOffTime() async {
    final result = await showTimePicker(
      context: viewContext,
      initialTime: selectedPickupTime ?? TimeOfDay.now(),
    );

    //
    if (result != null) {
      selectedPickupTime = result;
      pickupTime = result.format(viewContext);
      timeTEC.text = pickupTime;

      try {
        packageCheckout.time = "${result.hour}:${result.minute}";
      } catch (error) {
        packageCheckout.time = "$pickupTime";
      }
      notifyListeners();
    }
  }

  changeSelectedPaymentMethod(PaymentMethod paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    packageCheckout.paymentMethod = paymentMethod;
    notifyListeners();
  }

  //Form validationns
  validateDeliveryInfo() {
    if (deliveryInfoFormKey.currentState.validate()) {
      nextForm(3);
    }
  }

  validateRecipientInfo() {
    if (recipientInfoFormKey.currentState.validate()) {
      packageCheckout.recipientName = recipientNameTEC.text;
      packageCheckout.recipientPhone = recipientPhoneTEC.text;
      nextForm(4);
    }
  }

  validateDeliveryParcelInfo() {
    if (packageInfoFormKey.currentState.validate()) {
      //
      packageCheckout.weight = packageWeightTEC.text;
      packageCheckout.width = packageWidthTEC.text;
      packageCheckout.length = packageLengthTEC.text;
      packageCheckout.height = packageHeightTEC.text;
      nextForm(5);
    }
  }

  //Submit form
  prepareOrderSummary() async {
    //
    nextForm(6);
    setBusyForObject(packageCheckout, true);
    try {
      final mPackageCheckout = await packageRequest.parcelSummary(
        vendorId: selectedVendor.id,
        packageTypeId: selectedPackgeType.id,
        pickupLocationId: pickupLocation.id,
        dropoffLocationId: dropoffLocation.id,
        stops: packageCheckout.stopsLocation,
        packageWeight: packageWeightTEC.text,
      );

      //
      packageCheckout.copyWith(packageCheckout: mPackageCheckout);

      clearErrors();
    } catch (error) {
      print("Package error ==> $error");
      setErrorForObject(packageCheckout, error);
    }
    setBusyForObject(packageCheckout, false);
  }

  //Submit form
  initiateOrderPayment() async {
    //show loading dialog
    CoolAlert.show(
      context: viewContext,
      type: CoolAlertType.loading,
      barrierDismissible: false,
      title: "Checkout".i18n,
      text: "Processing order. Please wait...".i18n,
    );

    try {
      //
      final apiResponse = await checkoutRequest.newPackageOrder(
        packageCheckout,
        note: noteTEC.text,
      );

      //close loading dialog
      viewContext.pop();

      //not error
      if (apiResponse.allGood) {
        //cash payment

        final paymentLink = apiResponse.body["link"].toString();
        if (!paymentLink.isEmpty) {
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
                viewContext.pop();
                showOrdersTab();
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
    } catch (error) {
      print("Error ==> $error");
    }
  }

  //
  showOrdersTab() {
    //
    onFinish();
    //switch tab to orders
    AppService.changeHomePageIndex(index: 1);
  }

  addNewStop() {
    if (AppStrings.maxParcelStops > (toTECs.length - 1)) {
      toTEC = TextEditingController();
      toTECs.add(toTEC);
      packageCheckout.stopsLocation.add(null);
      notifyListeners();
    }
  }

  removeStop(int index) {
    toTECs.removeAt(index);
    packageCheckout.stopsLocation.removeAt(index);
    notifyListeners();
  }
}
