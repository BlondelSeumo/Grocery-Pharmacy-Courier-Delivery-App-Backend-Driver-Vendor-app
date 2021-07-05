// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/option_group.dart';
import 'package:random_string/random_string.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discountPrice,
    this.capacity,
    this.unit,
    this.packageCount,
    this.featured,
    this.isFavourite,
    this.deliverable,
    this.isActive,
    this.vendorId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.photo,
    this.vendor,
    this.optionGroups,
    this.availableQty,
    this.selectedQty,
  }) {
    this.heroTag = randomAlphaNumeric(15) + "$id";
  }

  int id;
  String heroTag;
  String name;
  String description;
  double price;
  double discountPrice;
  String capacity;
  String unit;
  String packageCount;
  int featured;
  bool isFavourite;
  int deliverable;
  int isActive;
  int vendorId;
  int categoryId;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String photo;
  Vendor vendor;
  List<OptionGroup> optionGroups;

  //
  int availableQty;
  int selectedQty;

  factory Product.fromJson(Map<String, dynamic> json) {
    
    return Product(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      description: json["description"] == null ? "" : json["description"],
      price:
          json["price"] == null ? null : double.parse(json["price"].toString()),
      discountPrice: json["discount_price"] == null
          ? null
          : double.parse(json["discount_price"].toString()),
      capacity: json["capacity"] == null ? null : json["capacity"].toString(),
      unit: json["unit"] == null ? null : json["unit"],
      packageCount: json["package_count"] == null
          ? null
          : json["package_count"].toString(),
      featured: json["featured"] == null
          ? null
          : int.parse(json["featured"].toString()),
      isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
      deliverable: json["deliverable"] == null ? null : int.parse(json["deliverable"].toString()),
      isActive: json["is_active"] == null ? null : int.parse(json["is_active"].toString()),
      vendorId: json["vendor_id"] == null ? null : int.parse(json["vendor_id"].toString()),
      categoryId: json["category_id"] == null ? null : json["category_id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      formattedDate:
          json["formatted_date"] == null ? null : json["formatted_date"],
      photo: json["photo"] == null ? null : json["photo"],
      vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
      optionGroups: json["option_groups"] == null
          ? null
          : List<OptionGroup>.from(
              json["option_groups"].map((x) => OptionGroup.fromJson(x)),
            ),
      //
      availableQty: json["available_qty"] == null
          ? null
          : int.parse(json["available_qty"].toString()),
      selectedQty: json["selected_qty"] == null
          ? null
          : int.parse(json["selected_qty"].toString()),
    );
  }

  

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "discount_price": discountPrice == null ? null : discountPrice,
        "capacity": capacity == null ? null : capacity,
        "unit": unit == null ? null : unit,
        "package_count": packageCount == null ? null : packageCount,
        "featured": featured == null ? null : featured,
        "is_favourite": isFavourite == null ? null : isFavourite,
        "deliverable": deliverable == null ? null : deliverable,
        "is_active": isActive == null ? null : isActive,
        "vendor_id": vendorId == null ? null : vendorId,
        "category_id": categoryId == null ? null : categoryId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_date": formattedDate == null ? null : formattedDate,
        "photo": photo == null ? null : photo,
        "vendor": vendor == null ? null : vendor.toJson(),
        "option_groups": optionGroups == null
            ? null
            : List<dynamic>.from(optionGroups.map((x) => x.toJson())),

        //
        "available_qty": availableQty == null ? null : availableQty,
        "selected_qty": selectedQty == null ? null : selectedQty,
      };

  //getters
  get showDiscount => discountPrice > 0.00;
  get canBeDelivered => deliverable == 1;
  bool get hasStock => availableQty == null || availableQty > 0;
}
