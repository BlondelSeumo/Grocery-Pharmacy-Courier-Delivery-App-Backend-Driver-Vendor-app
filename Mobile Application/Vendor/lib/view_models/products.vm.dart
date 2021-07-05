import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/requests/product.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/views/pages/product/edit_product.page.dart';
import 'package:fuodz/views/pages/product/new_product.page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/product.i18n.dart';

class ProductViewModel extends MyBaseViewModel {
  //
  ProductViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  ProductRequest productRequest = ProductRequest();
  List<Product> products = [];
  //
  int queryPage = 1;
  String keyword = "";
  RefreshController refreshController = RefreshController();

  void initialise() {
    fetchMyProducts();
  }

  //
  fetchMyProducts({bool initialLoading = true}) async {
    if (initialLoading) {
      setBusy(true);
      refreshController.refreshCompleted();
      queryPage = 1;
    } else {
      queryPage++;
    }

    try {
      final mProducts = await productRequest.getProducts(
        page: queryPage,
        keyword: keyword,
      );
      if (!initialLoading) {
        products.addAll(mProducts);
        refreshController.loadComplete();
      } else {
        products = mProducts;
      }
      clearErrors();
    } catch (error) {
      print("Product Error ==> $error");
      setError(error);
    }

    setBusy(false);
  }

  //
  productSearch(String value) {
    keyword = value;
    fetchMyProducts();
  }

  //
  openProductDetails(Product product) {
    viewContext.navigator.pushNamed(
      AppRoutes.productDetailsRoute,
      arguments: product,
    );
  }

  void newProduct() async {
    final result = await viewContext.push(
      (context) => NewProductPage(),
    );
    //
    if (result != null) {
      fetchMyProducts();
    }
  }

  editProduct(Product product) async {
    //
    final result =
        await viewContext.push((context) => EditProductPage(product));
    if (result != null) {
      fetchMyProducts();
    }
  }

  changeProductStatus(Product product) {
    //
    CoolAlert.show(
      context: viewContext,
      type: CoolAlertType.confirm,
      title: "Status Update".i18n,
      text: "Are you sure you want to".i18n +
          " ${(product.isActive != 1 ? "Activate" : "Deactivate").i18n} ${product.name}?",
      onConfirmBtnTap: () {
        //
        viewContext.pop();
        processStatusUpdate(product);
      },
    );
  }

  processStatusUpdate(Product product) async {
    //
    product.isActive = product.isActive == 1 ? 0 : 1;
    //
    setBusyForObject(product.id, true);
    try {
      final apiResponse = await productRequest.updateDetails(
        product,
      );
      //
      if (apiResponse.allGood) {
        fetchMyProducts();
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
    setBusyForObject(product.id, false);
  }
  //

  deleteProduct(Product product) {
    //
    CoolAlert.show(
      context: viewContext,
      type: CoolAlertType.confirm,
      title: "Delete Product".i18n,
      text: "Are you sure you want to delete".i18n + " ${product.name}?",
      onConfirmBtnTap: () {
        //
        viewContext.pop();
        processDeletion(product);
      },
    );
  }

  processDeletion(Product product) async {
    //
    setBusyForObject(product.id, true);
    try {
      final apiResponse = await productRequest.deleteProduct(
        product,
      );
      //
      if (apiResponse.allGood) {
        products.removeWhere((element) => element.id == product.id);
      }
      //show dialog to present state
      CoolAlert.show(
        context: viewContext,
        type: apiResponse.allGood ? CoolAlertType.success : CoolAlertType.error,
        title: "Delete Product".i18n,
        text: apiResponse.message,
      );
      clearErrors();
    } catch (error) {
      print("delete product Error ==> $error");
      setError(error);
    }
    setBusyForObject(product.id, false);
  }
}
