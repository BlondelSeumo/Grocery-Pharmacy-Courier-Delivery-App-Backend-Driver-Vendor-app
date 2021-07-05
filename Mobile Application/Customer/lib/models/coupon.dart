import 'dart:convert';

import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/product.dart';

Coupon couponFromJson(String str) => Coupon.fromJson(json.decode(str));

String couponToJson(Coupon data) => json.encode(data.toJson());

class Coupon {
    Coupon({
        this.id,
        this.code,
        this.description,
        this.discount,
        this.percentage,
        this.expiresOn,
        this.times,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.formattedExpiresOn,
        this.products,
        this.vendors,
    });

    int id;
    String code;
    String description;
    double discount;
    int percentage;
    DateTime expiresOn;
    dynamic times;
    int isActive;
    DateTime createdAt;
    DateTime updatedAt;
    String formattedExpiresOn;
    List<Product> products;
    List<Vendor> vendors;

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        description: json["description"] == null ? null : json["description"],
        discount: json["discount"] == null ? null : double.parse(json["discount"].toString()),
        percentage: json["percentage"] == null ? null : json["percentage"],
        expiresOn: json["expires_on"] == null ? null : DateTime.parse(json["expires_on"]),
        times: json["times"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        formattedExpiresOn: json["formatted_expires_on"] == null ? null : json["formatted_expires_on"],
        products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        vendors: json["vendors"] == null ? null : List<Vendor>.from(json["vendors"].map((x) => Vendor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "description": description == null ? null : description,
        "discount": discount == null ? null : discount,
        "percentage": percentage == null ? null : percentage,
        "expires_on": expiresOn == null ? null : "${expiresOn.year.toString().padLeft(4, '0')}-${expiresOn.month.toString().padLeft(2, '0')}-${expiresOn.day.toString().padLeft(2, '0')}",
        "times": times,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_expires_on": formattedExpiresOn == null ? null : formattedExpiresOn,
        "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
        "vendors": vendors == null ? null : List<dynamic>.from(vendors.map((x) => x.toJson())),
    };
}