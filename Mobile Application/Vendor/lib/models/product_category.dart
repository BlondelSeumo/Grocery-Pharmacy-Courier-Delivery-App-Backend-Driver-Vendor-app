// To parse this JSON data, do
//
//     final productCategory = productCategoryFromJson(jsonString);

import 'dart:convert';

ProductCategory productCategoryFromJson(String str) => ProductCategory.fromJson(json.decode(str));

String productCategoryToJson(ProductCategory data) => json.encode(data.toJson());

class ProductCategory {
    ProductCategory({
        this.id,
        this.name,
        this.photo,
    });

    int id;
    String name;
    String photo;

    factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
    };
}
