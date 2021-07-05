import 'dart:convert';

PackageType packageTypeFromJson(String str) =>
    PackageType.fromJson(json.decode(str));

String packageTypeToJson(PackageType data) => json.encode(data.toJson());

class PackageType {
  PackageType({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
    this.photo,
  });

  int id;
  String name;
  String description;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  String formattedDate;
  String photo;

  factory PackageType.fromJson(dynamic json) => PackageType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? "" : json["description"],
        isActive: json["is_active"] == null
            ? null
            : int.parse(json["is_active"].toString()),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        formattedDate:
            json["formatted_date"] == null ? null : json["formatted_date"],
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "formatted_date": formattedDate == null ? null : formattedDate,
        "photo": photo == null ? null : photo,
      };
}
