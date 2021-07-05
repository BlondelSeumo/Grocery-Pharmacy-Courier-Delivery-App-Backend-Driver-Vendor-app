import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/category.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorCategoryProductsViewModel extends MyBaseViewModel {
  //
  VendorCategoryProductsViewModel(
    BuildContext context,
    this.category,
  ) {
    this.viewContext = context;
  }

  //
  Category category;
  final currencySymbol = AppStrings.currencySymbol;

  void productSelected(Product product) async {
    await viewContext.navigator.pushNamed(
      AppRoutes.product,
      arguments: product,
    );

    //
    notifyListeners();
  }
}
