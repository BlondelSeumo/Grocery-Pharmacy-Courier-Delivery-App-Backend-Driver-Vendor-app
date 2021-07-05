import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/cart.dart';
import 'package:fuodz/models/option.dart';
import 'package:fuodz/models/option_group.dart';
import 'package:fuodz/models/product.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/requests/favourite.request.dart';
import 'package:fuodz/requests/product.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/dialogs.i18n.dart';
import 'package:fuodz/constants/app_strings.dart';

class ProductDetailsViewModel extends MyBaseViewModel {
  //
  ProductDetailsViewModel(BuildContext context, this.product) {
    this.viewContext = context;
    updatedSelectedQty(1);
  }

  //
  ProductRequest _productRequest = ProductRequest();
  FavouriteRequest _favouriteRequest = FavouriteRequest();

  //
  Product product;
  List<Option> selectedProductOptions = [];
  List<int> selectedProductOptionsIDs = [];
  double subTotal = 0.0;
  double total = 0.0;
  final currencySymbol = AppStrings.currencySymbol;

  //
  void getProductDetails() async {
    //
    setBusyForObject(product, true);

    try {
      product = await _productRequest.productDetails(product.id);
      clearErrors();
      calculateTotal();
    } catch (error) {
      setError(error);
    }
    setBusyForObject(product, false);
  }

  //
  isOptionSelected(Option option) {
    return selectedProductOptionsIDs.contains(option.id);
  }

  //
  toggleOptionSelection(OptionGroup optionGroup, Option option) {
    //
    if (selectedProductOptionsIDs.contains(option.id)) {
      selectedProductOptionsIDs.remove(option.id);
      selectedProductOptions.remove(option);
    } else {
      //if it allows only one selection
      if (optionGroup.multiple == 0) {
        //
        final foundOption = selectedProductOptions.firstWhere(
            (option) => option.optionGroupId == optionGroup.id,
            orElse: () => null);
        if (foundOption != null) {
          selectedProductOptionsIDs.remove(foundOption.id);
          selectedProductOptions.remove(foundOption);
        }
      }

      selectedProductOptionsIDs.add(option.id);
      selectedProductOptions.add(option);
    }

    //
    calculateTotal();
  }

  //
  updatedSelectedQty(int qty) async {
    product.selectedQty = qty;
    calculateTotal();
  }

  //
  calculateTotal() {
    //
    double productPrice =
        !product.showDiscount ? product.price : product.discountPrice;

    //
    double totalOptionPrice = 0.0;
    selectedProductOptions.forEach((option) {
      totalOptionPrice += option.price;
    });

    //
    subTotal = productPrice + totalOptionPrice;
    total = subTotal * (product.selectedQty ?? 1);
    notifyListeners();
  }

  //
  addToFavourite() async {
    //
    setBusy(true);

    try {
      //
      final apiResponse = await _favouriteRequest.makeFavourite(product.id);
      if (apiResponse.allGood) {
        //
        product.isFavourite = true;

        //
        CoolAlert.show(
          context: viewContext,
          title: "",
          text: apiResponse.message,
          type: CoolAlertType.success,
        );
      } else {
        viewContext.showToast(
          msg: apiResponse.message,
          bgColor: Colors.red,
          textColor: Colors.white,
          position: VxToastPosition.top,
        );
      }
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  //
  addToCart({bool force = false}) async {
    //
    final cart = Cart();
    cart.price = subTotal;
    cart.product = product;
    cart.selectedQty = product.selectedQty ?? 1;
    cart.options = selectedProductOptions;
    cart.optionsIds = selectedProductOptionsIDs;
    //
    setBusy(true);

    try {
      //
      final canAddToCart = await CartServices.canAddToCart(cart);
      if (canAddToCart || force) {
        //
        await CartServices.addToCart(cart);
        //
        CoolAlert.show(
          context: viewContext,
          title: "Add to cart".i18n,
          text: "%s Added to cart".i18n.fill([product.name]),
          type: CoolAlertType.success,
          showCancelBtn: true,
          confirmBtnColor: AppColor.primaryColor,
          confirmBtnText: "GO TO CART".i18n,
          confirmBtnTextStyle:
              viewContext.textTheme.bodyText1.copyWith(fontSize: Vx.dp12),
          onConfirmBtnTap: () async {
            await AppService.changeHomePageIndex();
            viewContext.navigator.popUntil((route) => route.isFirst);
          },
          cancelBtnText: "Keep Shopping".i18n,
          cancelBtnTextStyle:
              viewContext.textTheme.bodyText1.copyWith(fontSize: Vx.dp12),
        );
      } else {
        //
        CoolAlert.show(
          context: viewContext,
          title: "Diifferent Vendor".i18n,
          text:
              "Are you sure you'd like to change vendors? Your current items in cart will be lost."
                  .i18n,
          type: CoolAlertType.confirm,
          onConfirmBtnTap: () async {
            //
            viewContext.pop();
            await CartServices.clearCart();
            addToCart(force: true);
          },
        );
      }
    } catch (error) {
      print("Cart Error => $error");
      setError(error);
    }
    setBusy(false);
  }

  void openVendorPage() {
    viewContext.navigator.pushNamed(
      AppRoutes.vendorDetails,
      arguments: product.vendor,
    );
  }
}
