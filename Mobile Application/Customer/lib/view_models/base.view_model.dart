import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/cart.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/widgets/bottomsheets/delivery_address_picker.bottomsheet.dart';
import 'package:geocoder/model.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/dialogs.i18n.dart';
import 'package:firestore_repository/firestore_repository.dart';

class MyBaseViewModel extends BaseViewModel {
  //
  BuildContext viewContext;
  final formKey = GlobalKey<FormState>();
  final currencySymbol = AppStrings.currencySymbol;
  DeliveryAddress deliveryaddress = DeliveryAddress();
  String firebaseVerificationId;

  void initialise() {
    FirestoreRepository();
  }

  //
  //open delivery address picker
  void pickDeliveryAddress() {
    //
    showModalBottomSheet(
        context: viewContext,
        builder: (context) {
          return DeliveryAddressPicker(
            allowOnMap: true,
            onSelectDeliveryAddress: (mDeliveryaddress) {
              viewContext.pop();
              deliveryaddress = mDeliveryaddress;
              notifyListeners();

              //
              final address = Address(
                coordinates: Coordinates(
                    deliveryaddress.latitude, deliveryaddress.longitude),
                addressLine: deliveryaddress.address,
              );
              //
              LocationService.currenctAddress = address;
              //
              LocationService.currenctAddressSubject.sink.add(address);
            },
          );
        });
  }

  //
  bool isAuthenticated() {
    return AuthServices.authenticated();
  }

  //
  void openLogin() async {
    await viewContext.navigator.pushNamed(AppRoutes.loginRoute);
    notifyListeners();
  }

  //
  //
  Future<DeliveryAddress> showDeliveryAddressPicker() async {
    //
    DeliveryAddress selectedDeliveryAddress;

    //
    await showModalBottomSheet(
      context: viewContext,
      builder: (context) {
        return DeliveryAddressPicker(
          onSelectDeliveryAddress: (deliveryAddress) {
            viewContext.pop();
            selectedDeliveryAddress = deliveryAddress;
          },
        );
      },
    );

    return selectedDeliveryAddress;
  }

  //
  addToCartDirectly(Product product, int qty, {bool force = false}) async {
    //
    if (qty <= 0) {
      //
      final mProductsInCart = CartServices.productsInCart;
      final previousProductIndex = mProductsInCart.indexWhere(
        (e) => e.product.id == product.id,
      );
      //
      if (previousProductIndex >= 0) {
        mProductsInCart.removeAt(previousProductIndex);
        await CartServices.saveCartItems(mProductsInCart);
      }
      return;
    }
    //
    final cart = Cart();
    cart.price = (product.showDiscount ? product.discountPrice : product.price);
    product.selectedQty = qty;
    cart.product = product;
    cart.selectedQty = product.selectedQty ?? 1;
    cart.options = [];
    cart.optionsIds = [];

    //

    try {
      //
      final canAddToCart = await CartServices.canAddToCart(cart);
      if (canAddToCart || force) {
        //
        final mProductsInCart = CartServices.productsInCart;
        final previousProductIndex = mProductsInCart.indexWhere(
          (e) => e.product.id == product.id,
        );
        //
        if (previousProductIndex >= 0) {
          mProductsInCart.removeAt(previousProductIndex);
          mProductsInCart.insert(previousProductIndex, cart);
          await CartServices.saveCartItems(mProductsInCart);
        } else {
          await CartServices.addToCart(cart);
        }
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
            addToCartDirectly(product, qty, force: true);
          },
        );
      }
    } catch (error) {
      print("Cart Error => $error");
      setError(error);
    }
  }
}
