// To parse this JSON data, do
//
//     final optionGroup = optionGroupFromJson(jsonString);

import 'dart:convert';

import 'package:fuodz/models/option.dart';

OptionGroup optionGroupFromJson(String str) => OptionGroup.fromJson(json.decode(str));

String optionGroupToJson(OptionGroup data) => json.encode(data.toJson());

class OptionGroup {
    OptionGroup({
        this.id,
        this.name,
        this.multiple,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.laravelThroughKey,
        this.formattedDate,
        this.photo,
        this.options,
    });

    int id;
    String name;
    int multiple;
    int isActive;
    DateTime createdAt;
    DateTime updatedAt;
    int laravelThroughKey;
    String formattedDate;
    String photo;
    List<Option> options;

    factory OptionGroup.fromJson(Map<String, dynamic> json) => OptionGroup(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        multiple: json["multiple"] == null ? null : json["multiple"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        laravelThroughKey: json["laravel_through_key"] == null ? null : json["laravel_through_key"],
        formattedDate: json["formatted_date"] == null ? null : json["formatted_date"],
        photo: json["photo"] == null ? null : json["photo"],
        options: json["options"] == null ? null : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "multiple": multiple == null ? null : multiple,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "laravel_through_key": laravelThroughKey == null ? null : laravelThroughKey,
        "formatted_date": formattedDate == null ? null : formattedDate,
        "photo": photo == null ? null : photo,
        "options": options == null ? null : List<dynamic>.from(options.map((x) => x.toJson())),
    };
}