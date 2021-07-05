import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/models/package_type_pricing.dart';
import 'package:fuodz/requests/package_type_pricing.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/views/pages/package_types/add_package_type_pricing.page.dart';
import 'package:fuodz/views/pages/package_types/edit_package_type_pricing.page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/pricing.i18n.dart';

class PackageTypePricingViewModel extends MyBaseViewModel {
  //
  PackageTypePricingViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  PackageTypePricingRequest packageTypePricingRequest =
      PackageTypePricingRequest();
  List<PackageTypePricing> packageTypePricings = [];
  RefreshController refreshController = RefreshController();

  void initialise() {
    fetchMyPricings();
  }

  //
  fetchMyPricings({bool initialLoading = true}) async {
    setBusy(true);
    refreshController.refreshCompleted();

    try {
      packageTypePricings = await packageTypePricingRequest.getPricings();
      refreshController.loadComplete();
      clearErrors();
    } catch (error) {
      print("Package Type Pricing Error ==> $error");
      setError(error);
    }

    setBusy(false);
  }

  void newPackageTypePricing() async {
    //
    final result = await viewContext.push((context) => NewPackagePricingPage());
    if (result != null) {
      fetchMyPricings();
    }
  }

  editPricing(PackageTypePricing packageTypePricing) async {
    //
    final result = await viewContext
        .push((context) => EditPackagePricingPage(packageTypePricing));
    if (result != null) {
      fetchMyPricings();
    }
  }

  changePricingStatus(PackageTypePricing packageTypePricing) {
    //
    CoolAlert.show(
      context: viewContext,
      type: CoolAlertType.confirm,
      title: "Status Update".i18n,
      text: "Are you sure you want to".i18n +
          " ${(packageTypePricing.isActive != 1 ? "Activate" : "Deactivate").i18n} ${packageTypePricing.packageType.name}?",
      onConfirmBtnTap: () {
        //
        viewContext.pop();
        processStatusUpdate(packageTypePricing);
      },
    );
  }

  processStatusUpdate(PackageTypePricing packageTypePricing) async {
    //
    packageTypePricing.isActive = packageTypePricing.isActive == 1 ? 0 : 1;
    //
    setBusyForObject(packageTypePricing.id, true);
    try {
      final apiResponse = await packageTypePricingRequest.updateDetails(
        packageTypePricing,
      );
      //
      if (apiResponse.allGood) {
        fetchMyPricings();
      }
      //show dialog to present state
      CoolAlert.show(
        context: viewContext,
        type: apiResponse.allGood ? CoolAlertType.success : CoolAlertType.error,
        title: "Status Update".i18n,
        text: apiResponse.message,
      );
      clearErrors();
    } catch (error) {
      print("Update Status Package Type Pricing Error ==> $error");
      setError(error);
    }
    setBusyForObject(packageTypePricing.id, false);
  }
  //

  deletePricing(PackageTypePricing packageTypePricing) {
    //
    CoolAlert.show(
      context: viewContext,
      type: CoolAlertType.confirm,
      title: "Delete Pricing".i18n,
      text: "Are you sure you want to delete".i18n +
          " ${packageTypePricing.packageType.name}?",
      onConfirmBtnTap: () {
        //
        viewContext.pop();
        processDeletion(packageTypePricing);
      },
    );
  }

  processDeletion(PackageTypePricing packageTypePricing) async {
    //
    setBusyForObject(packageTypePricing.id, true);
    try {
      final apiResponse = await packageTypePricingRequest.deletePricing(
        packageTypePricing,
      );
      //
      if (apiResponse.allGood) {
        fetchMyPricings();
      }
      //show dialog to present state
      CoolAlert.show(
        context: viewContext,
        type: apiResponse.allGood ? CoolAlertType.success : CoolAlertType.error,
        title: "Delete Pricing".i18n,
        text: apiResponse.message,
      );
      clearErrors();
    } catch (error) {
      print("elete Package Type Pricing Error ==> $error");
      setError(error);
    }
    setBusyForObject(packageTypePricing.id, false);
  }
}
