import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/models/package_checkout.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/services/http.service.dart';

class CheckoutRequest extends HttpService {
  //
  Future<List<PaymentMethod>> getPaymentOptions() async {
    final apiResult = await get(Api.paymentMethods);

    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data.map((jsonObject) {
        return PaymentMethod.fromJson(jsonObject);
      }).toList();
    } else {
      throw apiResponse.message;
    }
  }

  Future<ApiResponse> newOrder(
    CheckOut checkout, {
    String note = "",
    String tip = "",
  }) async {
    final apiResult = await post(
      Api.orders,
      {
        "tip": tip,
        "note": note,
        "pickup_date": checkout.deliverySlotDate,
        "pickup_time": checkout.deliverySlotTime,
        "products": checkout.cartItems,
        "vendor_id": checkout.cartItems.first.product.vendorId,
        "delivery_address_id": checkout.deliveryAddress?.id,
        "payment_method_id": checkout.paymentMethod.id,
        "sub_total": checkout.subTotal,
        "discount": checkout.discount,
        "delivery_fee": checkout.deliveryFee,
        "tax": checkout.tax,
        "total": checkout.total,
      },
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> newPackageOrder(
    PackageCheckout packageCheckout, {
    String note,
  }) async {
    final apiResult = await post(
      Api.orders,
      {
        "type": "package",
        "note": note,
        "package_type_id": packageCheckout.packageType.id,
        "vendor_id": packageCheckout.vendor.id,
        "pickup_date": packageCheckout.date,
        "pickup_time": packageCheckout.time,
        "pickup_location_id": packageCheckout.pickupLocation.id,
        "dropoff_location_id": packageCheckout.stopsLocation != null
            ? packageCheckout.stopsLocation.last.id
            : packageCheckout?.dropoffLocation?.id,
        "stops": packageCheckout.stopsLocation != null
            ? packageCheckout.stopsLocation
                .sublist(0, packageCheckout.stopsLocation.length - 1)
                .map((e) => {"id": e.id})
                .toList()
            : [],
        "recipient_name": packageCheckout.recipientName,
        "recipient_phone": packageCheckout.recipientPhone,
        "weight": packageCheckout.weight,
        "width": packageCheckout.width,
        "length": packageCheckout.length,
        "height": packageCheckout.height,
        "payment_method_id": packageCheckout.paymentMethod.id,
        "sub_total": packageCheckout.subTotal,
        "discount": packageCheckout.discount,
        "delivery_fee": packageCheckout.deliveryFee,
        "tax": packageCheckout.tax,
        "total": packageCheckout.total,
      },
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }
}
