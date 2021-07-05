// To parse this JSON data, do
//
//     final deliverySlot = deliverySlotFromJson(jsonString);

import 'dart:convert';

DeliverySlot deliverySlotFromJson(String str) => DeliverySlot.fromJson(json.decode(str));

String deliverySlotToJson(DeliverySlot data) => json.encode(data.toJson());

class DeliverySlot {
    DeliverySlot({
        this.date,
        this.times,
    });

    DateTime date;
    List<String> times;

    factory DeliverySlot.fromJson(Map<String, dynamic> json) => DeliverySlot(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        times: json["times"] == null ? null : List<String>.from(json["times"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "date": date == null ? null : date.toIso8601String(),
        "times": times == null ? null : List<dynamic>.from(times.map((x) => x)),
    };
}
