class Currency {
  int id;
  String code = "USD";
  String symbol = "\$";

  Currency();

  factory Currency.fromJSON(dynamic json) {
    final currency = Currency();
    currency.id = json["id"];
    currency.code = json["code"];
    currency.symbol = json["symbol"];
    return currency;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'symbol': symbol,
      };
}
