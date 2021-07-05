import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/requests/product.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ForYouProductsViewModel extends MyBaseViewModel {
  //
  ProductRequest _productRequest = ProductRequest();
  //
  List<Product> products = [];

  ForYouProductsViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  initialise() async {
    setBusy(true);
    try {
      products = await _productRequest.forYouProductsRequest();
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  //
  productSelected(Product product) async {
    viewContext.navigator.pushNamed(
      AppRoutes.product,
      arguments: product,
    );
  }
}
