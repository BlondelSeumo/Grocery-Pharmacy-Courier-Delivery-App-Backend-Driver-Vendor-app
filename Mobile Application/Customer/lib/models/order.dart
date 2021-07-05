// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/order_stop.dart';
import 'package:fuodz/models/package_type.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/order_product.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/models/user.dart';
import 'package:jiffy/jiffy.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.id,
    this.canRate,
    this.rateDriver,
    this.code,
    this.verificationCode,
    this.note,
    this.type,
    this.status,
    this.paymentStatus,
    this.subTotal,
    this.discount,
    this.deliveryFee,
    this.comission,
    this.tax,
    this.total,
    this.deliveryAddressId,
    this.paymentMethodId,
    this.vendorId,
    this.userId,
    this.driverId,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.paymentLink,
    this.orderProducts,
    this.orderStops,
    this.user,
    this.driver,
    this.deliveryAddress,
    this.paymentMethod,
    this.vendor,
    //
    this.packageType,
    this.pickupLocation,
    this.dropoffLocation,
    this.pickupDate,
    this.pickupTime,
    this.recipientName,
    this.recipientPhone,
    this.width,
    this.height,
    this.length,
    this.weight,
  });

  int id;
  bool canRate;
  bool rateDriver;
  String code;
  String verificationCode;
  String note;
  String type;
  String status;
  String paymentStatus;
  double subTotal;
  double discount;
  double deliveryFee;
  double comission;
  double tax;
  double total;
  int deliveryAddressId;
  int paymentMethodId;
  int vendorId;
  int userId;
  int driverId;
  String pickupDate;
  String pickupTime;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String paymentLink;
  List<OrderProduct> orderProducts;
  List<OrderStop> orderStops;
  User user;
  User driver;
  DeliveryAddress deliveryAddress;
  PaymentMethod paymentMethod;
  Vendor vendor;
  //Package related
  PackageType packageType;
  DeliveryAddress pickupLocation;
  DeliveryAddress dropoffLocation;
  String weight;
  String length;
  String height;
  String width;
  String recipientName;
  String recipientPhone;

  factory Order.fromJson(dynamic json) {
    return Order(
      id: json["id"] == null ? null : json["id"],
      canRate: json["can_rate"] == null ? null : json["can_rate"],
      rateDriver: json["can_rate_driver"] == null ? false : json["can_rate_driver"],
      code: json["code"] == null ? null : json["code"],
      verificationCode:
          json["verification_code"] == null ? "" : json["verification_code"],
      note: json["note"] == null ? "--" : json["note"],
      type: json["type"] == null ? null : json["type"],
      status: json["status"] == null ? null : json["status"],
      paymentStatus:
          json["payment_status"] == null ? null : json["payment_status"],
      subTotal: json["sub_total"] == null
          ? null
          : double.parse(json["sub_total"].toString()),
      discount: json["discount"] == null
          ? null
          : double.parse(json["discount"].toString()),
      deliveryFee: json["delivery_fee"] == null
          ? null
          : double.parse(json["delivery_fee"].toString()),
      comission: json["comission"] == null
          ? null
          : double.parse(json["comission"].toString()),
      //
      tax: json["tax"] == null ? null : double.parse(json["tax"].toString()),
      total:
          json["total"] == null ? null : double.parse(json["total"].toString()),
      deliveryAddressId: json["delivery_address_id"] == null
          ? null
          : int.parse(json["delivery_address_id"].toString()),
      //
      paymentMethodId: json["payment_method_id"] == null
          ? null
          : int.parse(json["payment_method_id"].toString()),
      vendorId: json["vendor_id"] == null
          ? null
          : int.parse(json["vendor_id"].toString()),
      userId: json["user_id"] == null
          ? null
          : int.parse(json["user_id"].toString()),
      driverId: json["driver_id"] == null
          ? null
          : int.parse(json["driver_id"].toString()),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      formattedDate:
          json["formatted_date"] == null ? null : json["formatted_date"],
      paymentLink: json["payment_link"] == null ? "" : json["payment_link"],
      //
      orderProducts: json["products"] == null
          ? null
          : List<OrderProduct>.from(
              json["products"].map((x) => OrderProduct.fromJson(x))),
      orderStops: json["stops"] == null
          ? null
          : List<OrderStop>.from(
              json["stops"].map((x) => OrderStop.fromJson(x))),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      driver: json["driver"] == null ? null : User.fromJson(json["driver"]),
      deliveryAddress: json["delivery_address"] == null
          ? null
          : DeliveryAddress.fromJson(json["delivery_address"]),
      paymentMethod: json["payment_method"] == null
          ? null
          : PaymentMethod.fromJson(json["payment_method"]),
      vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),

      //package related data
      packageType: json["package_type"] == null
          ? null
          : PackageType.fromJson(json["package_type"]),
      pickupLocation: json["pickup_location"] == null
          ? null
          : DeliveryAddress.fromJson(json["pickup_location"]),
      dropoffLocation: json["dropoff_location"] == null
          ? null
          : DeliveryAddress.fromJson(json["dropoff_location"]),
      recipientName: json["recipient_name"],
      recipientPhone: json["recipient_phone"],
      pickupDate: json["pickup_date"] != null
          ? Jiffy(json["pickup_date"]).format("dd MMM, yyyy")
          : "",
      pickupTime: "${json["pickup_date"]} ${json["pickup_time"]}",
      // Jiffy("${json["pickup_date"]} ${json["pickup_time"]}","yyyy-MM-dd hh:mm:ss").format("hh:mm a"),
      weight: json["weight"].toString() ?? "",
      length: json["length"].toString() ?? "",
      height: json["height"].toString() ?? "",
      width: json["width"].toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "verification_code": verificationCode,
        "note": note,
        "type": type,
        "status": status,
        "payment_status": paymentStatus,
        "sub_total": subTotal,
        "discount": discount,
        "delivery_fee": deliveryFee,
        "comission": comission,
        "tax": tax,
        "total": total,
        "delivery_address_id": deliveryAddressId,
        "payment_method_id": paymentMethodId,
        "vendor_id": vendorId,
        "user_id": userId,
        "driver_id": driverId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "formatted_date": formattedDate,
        "payment_link": paymentLink,
        "products": List<dynamic>.from(orderProducts.map((x) => x.toJson())),
        "stops": List<dynamic>.from(orderStops.map((x) => x.toJson())),
        "user": user.toJson(),
        "driver": driver.toJson(),
        "delivery_address": deliveryAddress.toJson(),
        "payment_method": paymentMethod.toJson(),
        "vendor": vendor.toJson(),
      };

  //getters

  //
  get isPaymentPending =>
      paymentStatus == "pending" && ["pending"].contains(status);
  get isPackageDelivery => type == "package";
  get isScheduled => status == "scheduled";

  //status => 'pending','preparing','enroute','failed','cancelled','delivered'
  get canChatVendor {
    if (!AppStrings.enableChat) {
      return false;
    }
    return vendor != null &&
        ["pending", "preparing", "enroute"].contains(status);
  }

  get canChatDriver {
    if (!AppStrings.enableChat) {
      return false;
    }
    return driver != null && ["enroute"].contains(status);
  }

  bool get canCancel => ["scheduled", "pending"].contains(status);

  bool get canRateVendor {
    return this.canRate && ["cancelled", "delivered"].contains(status);
  }

  bool get canRateDriver {
    return rateDriver && driverId != null && ["cancelled", "delivered"].contains(status);
  }
}
