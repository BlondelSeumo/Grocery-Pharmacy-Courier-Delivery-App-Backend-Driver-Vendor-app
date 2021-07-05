import 'package:fuodz/models/product.dart';
import 'package:supercharged/supercharged.dart';

class OrderProduct {
  OrderProduct({
    this.id,
    this.quantity,
    this.price,
    this.options,
    this.orderId,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.product,
  });

  int id;
  int quantity;
  double price;
  String options;
  int orderId;
  int productId;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  Product product;

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json["id"] == null ? null : json["id"].toString().toInt(),
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        options: json["options"] == null ? null : json["options"],
        orderId: json["order_id"] == null ? null : json["order_id"].toString().toInt(),
        productId: json["product_id"] == null ? null : json["product_id"].toString().toInt(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        formattedDate:
            json["formatted_date"] == null ? null : json["formatted_date"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "options": options == null ? null : options,
        "order_id": orderId == null ? null : orderId,
        "product_id": productId == null ? null : productId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_date": formattedDate == null ? null : formattedDate,
        "product": product == null ? null : product.toJson(),
      };
}
