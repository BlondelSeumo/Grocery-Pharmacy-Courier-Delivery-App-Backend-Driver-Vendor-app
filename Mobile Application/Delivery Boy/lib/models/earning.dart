// To parse this JSON data, do
//
//     final earning = earningFromJson(jsonString);

import 'dart:convert';

Earning earningFromJson(String str) => Earning.fromJson(json.decode(str));

String earningToJson(Earning data) => json.encode(data.toJson());

class Earning {
  Earning({
    this.id,
    this.amount,
    this.userId,
    this.vendorId,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.formattedUpdatedDate,
  });

  int id;
  double amount;
  int userId;
  dynamic vendorId;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String formattedUpdatedDate;

  factory Earning.fromJson(Map<String, dynamic> json) => Earning(
        id: json["id"] == null ? null : json["id"],
        amount: json["amount"] == null ? null : double.parse(json["amount"].toString()),
        userId: json["user_id"] == null ? null : json["user_id"],
        vendorId: json["vendor_id"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "amount": amount == null ? null : amount,
        "user_id": userId == null ? null : userId,
        "vendor_id": vendorId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_date": formattedDate == null ? null : formattedDate,
        "formatted_updated_date":
            formattedUpdatedDate == null ? null : formattedUpdatedDate,
      };
}
