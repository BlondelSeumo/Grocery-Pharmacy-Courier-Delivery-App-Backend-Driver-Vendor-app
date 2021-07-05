// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

import 'package:fuodz/models/product.dart';

Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

String menuToJson(Menu data) => json.encode(data.toJson());

class Menu {
  Menu({
    this.id,
    this.name,
    this.vendorId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.formattedUpdatedDate,
    this.photo,
    this.products,
  });

  int id;
  String name;
  int vendorId;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String formattedUpdatedDate;
  String photo;
  List<Product> products;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        formattedDate:
            json["formatted_date"] == null ? null : json["formatted_date"],
        formattedUpdatedDate: json["formatted_updated_date"] == null
            ? null
            : json["formatted_updated_date"],
        photo: json["photo"] == null ? null : json["photo"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "vendor_id": vendorId == null ? null : vendorId,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_date": formattedDate == null ? null : formattedDate,
        "formatted_updated_date":
            formattedUpdatedDate == null ? null : formattedUpdatedDate,
        "photo": photo == null ? null : photo,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
