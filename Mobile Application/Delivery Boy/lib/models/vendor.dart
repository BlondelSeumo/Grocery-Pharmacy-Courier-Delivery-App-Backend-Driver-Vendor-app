// To parse this JSON data, do
//
//     final vendor = vendorFromJson(jsonString);

import 'dart:convert';

import 'package:fuodz/models/menu.dart';
import 'package:fuodz/models/package_type_pricing.dart';
import 'package:random_string/random_string.dart';

class Vendor {
  Vendor({
    this.id,
    this.name,
    this.description,
    this.deliveryFee,
    this.deliveryRange,
    this.tax,
    this.phone,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.comission,
    this.pickup,
    this.delivery,
    this.rating,
    this.chargePerKm,
    this.isOpen,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.logo,
    this.featureImage,
    this.menus,
    this.packageTypesPricing,
    this.canRate,
  }) {
    this.heroTag = randomAlphaNumeric(15) + "$id";
  }

  int id;
  String heroTag;
  String name;
  String description;
  double deliveryFee;
  double deliveryRange;
  String tax;
  String phone;
  String email;
  String address;
  String latitude;
  String longitude;
  double comission;
  int pickup;
  int delivery;
  int rating;
  int chargePerKm;
  bool isOpen;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String logo;
  String featureImage;
  List<Menu> menus;
  List<PackageTypePricing> packageTypesPricing;
  bool canRate;

  factory Vendor.fromRawJson(String str) => Vendor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      description: json["description"] == null ? null : json["description"],
      deliveryFee:
          json["delivery_fee"] == null ? null : double.parse(json["delivery_fee"].toString()),
      deliveryRange: json["delivery_range"] == null
          ? null
          : double.parse(json["delivery_range"].toString()),
      tax: json["tax"] == null ? null : json["tax"],
      phone: json["phone"] == null ? null : json["phone"],
      email: json["email"] == null ? null : json["email"],
      address: json["address"] == null ? null : json["address"],
      latitude: json["latitude"] == null ? null : json["latitude"],
      longitude: json["longitude"] == null ? null : json["longitude"],
      comission: json["comission"] == null
          ? null
          : double.parse(json["comission"].toString()),
      pickup: json["pickup"] == null ? null : int.parse(json["pickup"].toString()),
      delivery: json["delivery"] == null ? null : int.parse(json["delivery"].toString()),
      rating: json["rating"] == null ? null : int.parse(json["rating"].toString()),
      chargePerKm: json["charge_per_km"] == null ? null : int.parse(json["charge_per_km"].toString()),
      isOpen: json["is_open"] == null ? null : json["is_open"],
      isActive: json["is_active"] == null ? null : int.parse(json["is_active"].toString()),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      formattedDate:
          json["formatted_date"] == null ? null : json["formatted_date"],
      logo: json["logo"] == null ? null : json["logo"],
      featureImage:
          json["feature_image"] == null ? null : json["feature_image"],
      menus: json["menus"] == null
          ? []
          : List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
      packageTypesPricing: json["package_types_pricing"] == null
          ? []
          : List<PackageTypePricing>.from(json["package_types_pricing"]
              .map((x) => PackageTypePricing.fromJson(x))),

      //
      canRate: json["can_rate"] == null ? null : json["can_rate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "delivery_fee": deliveryFee == null ? null : deliveryFee,
        "delivery_range": deliveryRange == null ? null : deliveryRange,
        "tax": tax == null ? null : tax,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "comission": comission == null ? null : comission,
        "pickup": pickup == null ? null : pickup,
        "delivery": delivery == null ? null : delivery,
        "rating": rating == null ? null : rating,
        "charge_per_km": chargePerKm == null ? null : chargePerKm,
        "is_open": isOpen == null ? null : isOpen,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_date": formattedDate == null ? null : formattedDate,
        "logo": logo == null ? null : logo,
        "feature_image": featureImage == null ? null : featureImage,
        "can_rate": canRate == null ? null : canRate,
        "menus": menus == null
            ? null
            : List<dynamic>.from(menus.map((x) => x.toJson())),
        "package_types_pricing": packageTypesPricing == null
            ? null
            : List<dynamic>.from(packageTypesPricing.map((x) => x.toJson())),
      };
}
