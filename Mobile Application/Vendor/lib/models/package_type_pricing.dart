// To parse this JSON data, do
//
//     final packageTypePricing = packageTypePricingFromJson(jsonString);

import 'dart:convert';

import 'package:fuodz/models/package_type.dart';

PackageTypePricing packageTypePricingFromJson(String str) =>
    PackageTypePricing.fromJson(json.decode(str));

String packageTypePricingToJson(PackageTypePricing data) =>
    json.encode(data.toJson());

class PackageTypePricing {
  PackageTypePricing({
    this.id,
    this.isActive,
    this.vendorId,
    this.packageTypeId,
    this.maxBookingDays,
    this.sizePrice,
    this.pricePerKg,
    this.distancePrice,
    this.basePrice,
    this.pricePerKm,
    this.packageType,
    this.autoReady,
    this.extraFields,
  });

  int id;
  int isActive;
  int vendorId;
  int packageTypeId;
  int maxBookingDays;
  double sizePrice;
  int pricePerKg;
  double distancePrice;
  double basePrice;
  int pricePerKm;
  PackageType packageType;
  bool autoReady;
  bool extraFields;

  factory PackageTypePricing.fromJson(Map<String, dynamic> json) {
    return PackageTypePricing(
        id: json["id"] == null ? null : json["id"],
        vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
        autoReady:
            (json["auto_assignment"] == null || json["auto_assignment"] == 0)
                ? false
                : true,
        extraFields:
            json["field_required"] == null ? false : json["field_required"],
        isActive: json["is_active"],
        packageTypeId:
            json["package_type_id"] == null ? null : json["package_type_id"],
        maxBookingDays:
            json["max_booking_days"] == null ? null : json["max_booking_days"],
        sizePrice: json["size_price"] == null
            ? null
            : double.parse(json["size_price"].toString()),
        pricePerKg: json["price_per_kg"] == null
            ? null
            : int.parse(json["price_per_kg"].toString()),
        distancePrice: json["distance_price"] == null
            ? null
            : double.parse(json["distance_price"].toString()),
        basePrice: json["base_price"] == null
            ? 0.00
            : double.parse(json["base_price"].toString()),
        pricePerKm: json["price_per_km"] == null
            ? null
            : int.parse(json["price_per_km"].toString()),
        packageType: PackageType.fromJson(json["package_type"]));
  }
  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "vendor_id": vendorId == null ? null : vendorId,
        "package_type_id": packageTypeId == null ? null : packageTypeId,
        "max_booking_days": maxBookingDays == null ? null : maxBookingDays,
        "size_price": sizePrice == null ? null : sizePrice,
        "price_per_kg": pricePerKg == null ? null : pricePerKg,
        "distance_price": distancePrice == null ? null : distancePrice,
        "base_price": basePrice,
        "is_active": isActive,
        "price_per_km": pricePerKm == null ? null : pricePerKm,
        "package_type": packageType,
      };
}
