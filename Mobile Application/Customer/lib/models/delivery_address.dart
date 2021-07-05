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
    this.state,
    this.country,
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
  String state;
  String country;
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
        state: json["state"],
        country: json["country"],
        latitude: double.parse(json["latitude"].toString()),
        longitude: double.parse(json["longitude"].toString()),
        distance: json["distance"] == null ? null : double.parse(json["distance"].toString()),
        isDefault: int.parse(json["is_default"].toString()),
        userId: int.parse(json["user_id"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        formattedDate: json["formatted_date"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "state": state,
        "country": country,
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
        "state": state,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "is_default": isDefault,
      };

  bool get defaultDeliveryAddress => isDefault == 1;
}
