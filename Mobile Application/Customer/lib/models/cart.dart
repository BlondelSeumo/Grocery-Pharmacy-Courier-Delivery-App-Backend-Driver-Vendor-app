import 'dart:convert';
import 'package:fuodz/models/option.dart';
import 'package:fuodz/models/product.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.price,
    this.product,
    this.options,
    this.optionsIds,
    this.selectedQty,
  });

  //
  int selectedQty;
  double price;
  Product product;
  List<Option> options;
  List<int> optionsIds;

  //

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      selectedQty: json["selected_qty"] == null ? null : json["selected_qty"],
      price: json["price"] == null ? null : double.parse(json["price"].toString()),
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
      options: json["options"] == null
          ? null
          : List<Option>.from(
              json["options"].map((x) => Option.fromJson(x)),
            ),
      optionsIds: json["options_ids"] == null
          ? null
          : List<int>.from(json["options_ids"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "selected_qty": selectedQty == null ? null : selectedQty,
        "price": price == null ? null : price,
        "product": product == null ? null : product.toJson(),
        "options": options == null
            ? null
            : List<dynamic>.from(options.map((x) => x.toJson())),
        "options_ids": optionsIds == null ? null : optionsIds,
        "options_flatten": optionsSentence,
      };

  //
  String get optionsSentence {
    var optionsSelected = "";
    final optionsLength = options.length ?? 0;
    options.asMap().forEach((index, option) {
      optionsSelected += option.name;
      if (optionsLength > (index) + 1) {
        optionsSelected += ", ";
      }
    });
    return optionsSelected;
  }
}
