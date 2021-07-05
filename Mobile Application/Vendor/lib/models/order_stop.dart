import 'package:fuodz/models/delivery_address.dart';

class OrderStop {
  OrderStop({
    this.id,
    this.orderId,
    this.stopId,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.deliveryAddress,
  });

  int id;
  int orderId;
  int stopId;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  DeliveryAddress deliveryAddress;

  factory OrderStop.fromJson(Map<String, dynamic> json) => OrderStop(
        id: json["id"] == null ? null : json["id"],
        orderId: json["order_id"] == null
            ? null
            : int.parse(json["order_id"].toString()),
        stopId: json["stop_id"] == null
            ? null
            : int.parse(json["stop_id"].toString()),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        formattedDate:
            json["formatted_date"] == null ? null : json["formatted_date"],
        deliveryAddress: json["delivery_address"] == null
            ? null
            : DeliveryAddress.fromJson(json["delivery_address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "order_id": orderId == null ? null : orderId,
        "stop_id": stopId == null ? null : stopId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_date": formattedDate == null ? null : formattedDate,
        "delivery_address":
            deliveryAddress == null ? null : deliveryAddress.toJson(),
      };
}
