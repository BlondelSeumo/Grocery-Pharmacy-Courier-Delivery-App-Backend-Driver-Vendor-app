import 'package:fuodz/models/cart.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/payment_method.dart';

class CheckOut {
  double subTotal;
  double discount;
  double deliveryFee;
  double tax;
  double total;
  double totalWithTip;
  String pickupTime;
  String pickupDate;
  bool isPickup;
  bool isScheduled;
  DeliveryAddress deliveryAddress;
  String deliverySlotDate;
  String deliverySlotTime;
  PaymentMethod paymentMethod;
  List<Cart> cartItems;

  //
  CheckOut({
    this.subTotal = 0.00,
    this.discount = 0.00,
    this.deliveryFee = 0.00,
    this.tax = 0.00,
    this.total = 0.00,
    this.totalWithTip = 0.00,
    this.isPickup,
    this.deliveryAddress,
    this.isScheduled,
    this.pickupDate,
    this.pickupTime,
    this.paymentMethod,
    this.cartItems,
    this.deliverySlotDate = "",
    this.deliverySlotTime = "",
  });
}
