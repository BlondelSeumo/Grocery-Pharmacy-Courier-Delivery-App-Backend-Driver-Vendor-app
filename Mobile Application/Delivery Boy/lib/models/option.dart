import 'dart:convert';

Option optionFromJson(String str) => Option.fromJson(json.decode(str));

String optionToJson(Option data) => json.encode(data.toJson());

class Option {
    Option({
        this.id,
        this.name,
        this.description,
        this.price,
        this.productId,
        this.optionGroupId,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.formattedDate,
        this.photo,
    });

    int id;
    String name;
    String description;
    double price;
    int productId;
    int optionGroupId;
    int isActive;
    DateTime createdAt;
    DateTime updatedAt;
    String formattedDate;
    String photo;

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        productId: json["product_id"] == null ? null : json["product_id"],
        optionGroupId: json["option_group_id"] == null ? null : json["option_group_id"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        formattedDate: json["formatted_date"] == null ? null : json["formatted_date"],
        photo: json["photo"] == null ? null : json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description,
        "price": price == null ? null : price,
        "product_id": productId == null ? null : productId,
        "option_group_id": optionGroupId == null ? null : optionGroupId,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_date": formattedDate == null ? null : formattedDate,
        "photo": photo == null ? null : photo,
    };
}
