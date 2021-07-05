import 'dart:convert';

DeliveryAddress deliveryAddressFromJson(String str) =>
    DeliveryAddress.fromJson(json.decode(str));

String deliveryAddressToJson(DeliveryAddress data) =>
    json.encode(data.toJson());

class DeliveryAddress {
  DeliveryAddress({
    this.id,
    this.name,
    this.city,
    this.address = "Current Location",
    this.latitude,
    this.longitude,
    this.isDefault,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.photo,
    this.distance,
  });

  int id;
  String name;
  String address;
  String city;
  double latitude;
  double longitude;
  int isDefault;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String photo;
  double distance;

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        isDefault: json["is_default"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        formattedDate: json["formatted_date"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
        "is_default": isDefault,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "formatted_date": formattedDate,
        "photo": photo,
      };
  
  //
  Map<String, dynamic> toSaveJson() => {
        "name": name,
        "address": address,
        "city": city,
        "latitude": latitude,
        "longitude": longitude,
        "is_default": isDefault,
      };

  bool get defaultDeliveryAddress => isDefault == 1;
}
