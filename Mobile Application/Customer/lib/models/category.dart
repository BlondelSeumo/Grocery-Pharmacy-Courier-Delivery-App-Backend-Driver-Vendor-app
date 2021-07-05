import 'package:fuodz/models/product.dart';

class Category {
  int id;
  String name;
  String imageUrl;
  List<Product> products;
  List<Category> subcategories;

  Category({
    this.id,
    this.name,
    this.imageUrl,
    this.products,
  });

  factory Category.fromJson(dynamic jsonObject) {
    final category = Category();
    category.id = jsonObject["id"];
    category.name = jsonObject["name"];
    category.imageUrl = jsonObject["photo"];
    category.products = jsonObject["products"] == null
        ? null
        : List<Product>.from(
            jsonObject["products"].map(
              (x) => Product.fromJson(x),
            ),
          );
    category.subcategories = jsonObject["sub_categories"] == null
        ? []
        : List<Category>.from(
            jsonObject["sub_categories"].map(
              (x) => Category.fromJson(x),
            ),
          );
    return category;
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "photo": imageUrl == null ? null : imageUrl,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
        "subcategories": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
