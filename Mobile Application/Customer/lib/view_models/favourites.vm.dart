import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/requests/favourite.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/favourites.i18n.dart';

class FavouritesViewModel extends MyBaseViewModel {
  //
  FavouriteRequest favouriteRequest = FavouriteRequest();
  List<Product> products = [];

  //
  FavouritesViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  void initialise() {
    //
    fetchProducts();
  }

  //
  fetchProducts() async {
    //
    setBusyForObject(products, true);
    try {
      products = await favouriteRequest.favourites();
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusyForObject(products, false);
  }

  //
  removeFavourite(Product product) {
    //
    CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.confirm,
        title: "Remove Product From Favourite".i18n,
        text:
            "Are you sure you want to remove this product from your favourite list?"
                .i18n,
        confirmBtnText: "Remove".i18n,
        onConfirmBtnTap: () {
          viewContext.pop();
          processRemove(product);
        });
  }

  //
  processRemove(Product product) async {
    setBusy(true);
    //
    final apiResponse = await favouriteRequest.removeFavourite(
      product.id,
    );

    //remove from list
    if (apiResponse.allGood) {
      products.remove(product);
    }

    setBusy(false);

    CoolAlert.show(
      context: viewContext,
      type: apiResponse.allGood ? CoolAlertType.success : CoolAlertType.error,
      title: "Remove Product From Favourite".i18n,
      text: apiResponse.message,
    );
  }

  openProductDetails(Product product) {
    viewContext.navigator.pushNamed(
      AppRoutes.product,
      arguments: product,
    );
  }
}
