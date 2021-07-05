import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/models/menu.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/models/product_category.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/requests/product.request.dart';
import 'package:fuodz/requests/vendor.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/product.i18n.dart';

class EditProductViewModel extends MyBaseViewModel {
  //
  EditProductViewModel(BuildContext context, this.product) {
    this.viewContext = context;
  }

  //
  ProductRequest productRequest = ProductRequest();
  VendorRequest vendorRequest = VendorRequest();
  Product product;
  List<ProductCategory> categories = [];
  List<ProductCategory> subCategories = [];
  List<Menu> menus = [];
  File selectedPhoto;

  void initialise() {
    fetchProductCategories();
    fetchProductSubCategories();
    fetchMenus();
  }

  //
  fetchProductCategories() async {
    setBusyForObject(categories, true);

    try {
      categories = await productRequest.getProductCategories();
      clearErrors();
    } catch (error) {
      print("Categories Error ==> $error");
      setError(error);
    }

    setBusyForObject(categories, false);
  }

  fetchProductSubCategories() async {
    setBusyForObject(subCategories, true);

    try {
      subCategories = await productRequest.getProductCategories(
        subCat: true,
      );
      clearErrors();
    } catch (error) {
      print("subCategories Error ==> $error");
      setError(error);
    }

    setBusyForObject(subCategories, false);
  }

  fetchMenus() async {
    setBusyForObject(menus, true);

    try {
      final response = await vendorRequest.getVendorDetails();
      final vendor = Vendor.fromJson(response["vendor"]);
      menus = vendor.menus;
      clearErrors();
    } catch (error) {
      print("menus Error ==> $error");
      setError(error);
    }

    setBusyForObject(menus, false);
  }

  //
  onImageselected(File file) {
    selectedPhoto = file;
    notifyListeners();
  }

  //
  processUpdateProduct() async {
    if (formBuilderKey.currentState.saveAndValidate()) {
      final newProductData = formBuilderKey.currentState.value;
      print("Product ==> ${jsonEncode(newProductData)}");
      //
      setBusy(true);

      try {
        final apiResponse = await productRequest.updateDetails(
          product,
          data: formBuilderKey.currentState.value,
          photo: selectedPhoto,
        );
        //
        //show dialog to present state
        CoolAlert.show(
            context: viewContext,
            type: apiResponse.allGood
                ? CoolAlertType.success
                : CoolAlertType.error,
            title: "Update Product".i18n,
            text: apiResponse.message,
            onConfirmBtnTap: () {
              viewContext.pop();
              if (apiResponse.allGood) {
                viewContext.pop(true);
              }
            });
        clearErrors();
      } catch (error) {
        print("Update product Error ==> $error");
        setError(error);
      }

      setBusy(false);
    }
  }
}
