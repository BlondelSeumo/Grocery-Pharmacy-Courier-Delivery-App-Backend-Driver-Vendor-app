// To parse this JSON data, do
//
//     final newOrder = newOrderFromJson(jsonString);

import 'dart:convert';

NewOrder newOrderFromJson(String str) => NewOrder.fromJson(json.decode(str));

String newOrderToJson(NewOrder data) => json.encode(data.toJson());

class NewOrder {
  NewOrder({
    this.amount,
    this.dropoff,
    this.id,
    this.pickup,
    this.range,
    this.distance,
    this.vendorId,
    this.isParcel,
    this.packageType,
  });

  String amount;
  Dropoff dropoff;
  int id;
  Pickup pickup;
  double range;
  double distance;
  double orderDistance;
  int vendorId;
  bool isParcel;
  String packageType;

  factory NewOrder.fromJson(Map<String, dynamic> json) => NewOrder(
        amount: json["amount"] == null ? null : json["amount"],
        dropoff:
            json["dropoff"] == null ? null : Dropoff.fromJson(json["dropoff"]),
        id: json["id"] == null ? null : json["id"],
        pickup: json["pickup"] == null ? null : Pickup.fromJson(json["pickup"]),
        range: json["range"] == null
            ? null
            : double.parse(json["range"].toString()),
        vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
        isParcel: json["is_parcel"] == null ? false : json["is_parcel"],
        packageType: json["package_type"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "dropoff": dropoff == null ? null : dropoff.toJson(),
        "id": id == null ? null : id,
        "pickup": pickup == null ? null : pickup.toJson(),
        "range": range == null ? null : range,
        "vendor_id": vendorId == null ? null : vendorId,
        "is_parcel": isParcel,
        "package_type": packageType,
      };
}

class Dropoff {
  Dropoff({
    this.address,
    this.city,
    this.lat,
    this.long,
  });

  String address;
  String city;
  double lat;
  double long;

  factory Dropoff.fromJson(Map<String, dynamic> json) => Dropoff(
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? "" : json["city"],
        lat: json["lat"] == null ? null : double.parse(json["lat"].toString()),
        long:
            json["long"] == null ? null : double.parse(json["long"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "city": city,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
      };
}

class Pickup {
  Pickup({
    this.address,
    this.city,
    this.lat,
    this.long,
  });

  String address;
  String city;
  double lat;
  double long;

  factory Pickup.fromJson(Map<String, dynamic> json) => Pickup(
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? "" : json["city"],
        lat: json["lat"] == null ? null : double.parse(json["lat"].toString()),
        long:
            json["long"] == null ? null : double.parse(json["long"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "city": city,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
      };
}
