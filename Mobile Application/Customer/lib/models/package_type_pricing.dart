// To parse this JSON data, do
//
//     final packageTypePricing = packageTypePricingFromJson(jsonString);

import 'dart:convert';
import 'package:supercharged/supercharged.dart';

PackageTypePricing packageTypePricingFromJson(String str) =>
    PackageTypePricing.fromJson(json.decode(str));

String packageTypePricingToJson(PackageTypePricing data) =>
    json.encode(data.toJson());

class PackageTypePricing {
  PackageTypePricing({
    this.id,
    this.vendorId,
    this.packageTypeId,
    this.maxBookingDays,
    this.sizePrice,
    this.pricePerKg,
    this.distancePrice,
    this.pricePerKm,
    this.fieldRequired,
  });

  int id;
  int vendorId;
  int packageTypeId;
  int maxBookingDays;
  double sizePrice;
  double pricePerKg;
  double distancePrice;
  double pricePerKm;
  bool fieldRequired;

  factory PackageTypePricing.fromJson(Map<String, dynamic> json) {
    
    return PackageTypePricing(
      id: json["id"] == null ? null : json["id"],
      vendorId: json["vendor_id"] == null
          ? null
          : json["vendor_id"].toString().toInt(),
      packageTypeId: json["package_type_id"] == null
          ? null
          : json["package_type_id"].toString().toInt(),
      maxBookingDays: json["max_booking_days"] == null
          ? null
          : json["max_booking_days"].toString().toInt(),
      sizePrice: json["size_price"] == null
          ? null
          : double.parse(json["size_price"].toString()),
      pricePerKg: json["price_per_kg"] == null
          ? null
          : double.parse(json["price_per_kg"].toString()),
      distancePrice: json["distance_price"] == null
          ? null
          : double.parse(json["distance_price"].toString()),
      pricePerKm: json["price_per_km"] == null
          ? null
          : double.parse(json["price_per_km"].toString()),
      fieldRequired:
          json["field_required"] == null ? true : json["field_required"],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "vendor_id": vendorId == null ? null : vendorId,
        "package_type_id": packageTypeId == null ? null : packageTypeId,
        "max_booking_days": maxBookingDays == null ? null : maxBookingDays,
        "size_price": sizePrice == null ? null : sizePrice,
        "price_per_kg": pricePerKg == null ? null : pricePerKg,
        "distance_price": distancePrice == null ? null : distancePrice,
        "price_per_km": pricePerKm == null ? null : pricePerKm,
        "field_required": fieldRequired,
      };
}
