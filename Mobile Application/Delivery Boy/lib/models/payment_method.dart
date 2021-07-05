import 'dart:convert';

PaymentMethod paymentMethodFromJson(String str) => PaymentMethod.fromJson(json.decode(str));

String paymentMethodToJson(PaymentMethod data) => json.encode(data.toJson());

class PaymentMethod {
    PaymentMethod({
        this.id,
        this.name,
        this.isActive,
        this.isCash,
        this.createdAt,
        this.updatedAt,
        this.formattedDate,
        this.photo,
    });

    int id;
    String name;
    int isActive;
    int isCash;
    DateTime createdAt;
    DateTime updatedAt;
    String formattedDate;
    String photo;

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        isActive: json["is_active"],
        isCash: json["is_cash"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        formattedDate: json["formatted_date"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_active": isActive,
        "is_cash": isCash,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "formatted_date": formattedDate,
        "photo": photo,
    };
}
