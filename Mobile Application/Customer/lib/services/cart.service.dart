import 'dart:convert';
import 'package:fuodz/models/cart.dart';
import 'package:fuodz/services/local_storage.service.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class CartServices {
  //
  static String cartItemsKey = "cart_items";
  static String totalItemKey = "total_cart_items";
  //
  static List<Cart> productsInCart = [];
  //
  static Future<void> getCartItems() async {
    //
    final cartList = await LocalStorageService.prefs.getString(
      cartItemsKey,
    );

    //
    if (cartList != null) {
      productsInCart = (jsonDecode(cartList) as List).map((cartObject) {
        return Cart.fromJson(cartObject);
      }).toList();
    } else {
      productsInCart = [];
    }
  }

  //
  static bool canAddToCart(Cart cart) {
    if (productsInCart.length > 0) {
      //
      final firstOfferInCart = productsInCart[0];
      if (firstOfferInCart.product.vendorId == cart.product.vendorId) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  static clearCart() async {
    await LocalStorageService.prefs.setString(
      cartItemsKey,
      null,
    );
    await updateTotalCartItemCount(0);
    productsInCart = [];
  }

  static addToCart(Cart cart) async {
    //
    try {
      final mProductsInCart = productsInCart;
      mProductsInCart.add(cart);
      await LocalStorageService.prefs.setString(
        cartItemsKey,
        jsonEncode(
          mProductsInCart,
        ),
      );
      //
      productsInCart = mProductsInCart;
      //update total item in cart count
      await updateTotalCartItemCount(productsInCart.length);
      await getCartItems();
    } catch (error) {
      print("Saving Cart Error => $error");
    }
  }

  static saveCartItems(List<Cart> productsInCart) async {
    await LocalStorageService.prefs.setString(
      cartItemsKey,
      jsonEncode(
        productsInCart,
      ),
    );

    //update total item in cart count
    await updateTotalCartItemCount(productsInCart.length);

    await getCartItems();
  }

  static updateTotalCartItemCount(int total) async {
    //update total item in cart count
    await LocalStorageService.rxPrefs.setInt(totalItemKey, total);
  }

  //
}
