import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/cart.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/models/coupon.dart';
import 'package:fuodz/requests/cart.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/cart.i18n.dart';

class CartViewModel extends MyBaseViewModel {
  //
  CartRequest cartRequest = CartRequest();
  List<Cart> cartItems = [];
  int totalCartItems = 0;
  double subTotalPrice = 0.0;
  double discountCartPrice = 0.0;
  double totalCartPrice = 0.0;

  //
  bool canApplyCoupon = false;
  Coupon coupon;
  TextEditingController couponTEC = TextEditingController();

  //
  CartViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void initialise() async {
    //
    cartItems = CartServices.productsInCart;
    //
    calculateSubTotal();
  }

  //
  calculateSubTotal() {
    //
    totalCartItems = 0;
    subTotalPrice = 0;
    discountCartPrice = 0;

    //
    cartItems.forEach(
      (cartItem) {
        totalCartItems += cartItem.selectedQty;
        final totalProductPrice = cartItem.price * cartItem.selectedQty;
        subTotalPrice += totalProductPrice;

        //discount/coupon
        if (coupon != null) {
          final foundProduct = coupon.products.firstWhere(
              (product) => cartItem.product.id == product.id,
              orElse: () => null);
          final foundVendor = coupon.vendors.firstWhere(
              (vendor) => cartItem.product.vendorId == vendor.id,
              orElse: () => null);
          if (foundProduct != null ||
              foundVendor != null ||
              (coupon.products.isEmpty && coupon.vendors.isEmpty)) {
            if (coupon.percentage == 1) {
              discountCartPrice += (coupon.discount / 100) * totalProductPrice;
            } else {
              discountCartPrice += coupon.discount;
            }
          }
        }

        //
      },
    );

    //
    totalCartPrice = subTotalPrice - discountCartPrice;
    notifyListeners();
  }

  //
  deleteCartItem(int index) {
    //
    CoolAlert.show(
      context: viewContext,
      type: CoolAlertType.confirm,
      title: "Remove From Cart".i18n,
      text: "Are you sure you want to remove this product from cart?".i18n,
      confirmBtnText: "Yes".i18n,
      onConfirmBtnTap: () async {
        //
        //remove item/product from cart
        cartItems.removeAt(index);
        await CartServices.saveCartItems(cartItems);
        initialise();

        //close dialog
        viewContext.pop();
      },
    );
  }

  //
  updateCartItemQuantity(int qty, int index) async {
    cartItems[index].selectedQty = qty;
    await CartServices.saveCartItems(cartItems);
    initialise();
  }

  //
  couponCodeChange(String code) {
    canApplyCoupon = code.isNotBlank;
    notifyListeners();
  }

  //
  applyCoupon() async {
    //
    setBusyForObject(coupon, true);
    try {
      coupon = await cartRequest.fetchCoupon(couponTEC.text);
      clearErrors();
      //re-calculate the cart price with coupon
      calculateSubTotal();
    } catch (error) {
      setErrorForObject(coupon, error);
    }
    setBusyForObject(coupon, false);
  }

  //
  checkoutPressed() async {
    //
    bool canOpenCheckout = true;
    if (!AuthServices.authenticated()) {
      //
      final result =
          await viewContext.navigator.pushNamed(AppRoutes.loginRoute);
      if (result == null || !result) {
        canOpenCheckout = false;
      }
    }

    //
    CheckOut checkOut = CheckOut();
    checkOut.subTotal = subTotalPrice;
    checkOut.discount = discountCartPrice;
    checkOut.total = totalCartPrice;
    checkOut.cartItems = cartItems;

    //
    if (canOpenCheckout) {
      viewContext.navigator.pushNamed(
        AppRoutes.checkoutRoute,
        arguments: checkOut,
      );
    }
  }
}
