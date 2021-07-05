import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Wallet",
        "fr": "Portefeuille",
        "es": "Cartera",
        "de": "Brieftasche",
        "pt": "Carteira",
        "ar": "محفظة",
        "ko": "지갑"
      } +
      {
        "en": "Total Balance",
        "fr": "Solde total",
        "es": "Balance total",
        "de": "Gesamtsaldo",
        "pt": "Balanço total",
        "ar": "إجمالي الرصيد",
        "ko": "전체 균형"
      } +
      {
        "en": "Updated last at:",
        "fr": "Dernière mise à jour à:",
        "es": "Actualizado por última vez en:",
        "de": "Zuletzt aktualisiert um:",
        "pt": "Atualizado pela última vez em:",
        "ar": "آخر تحديث في:",
        "ko": "마지막 업데이트 날짜 :"
      } +
      {
        "en": "Top-Up Wallet",
        "fr": "Portefeuille de recharge",
        "es": "Billetera de recarga",
        "de": "Geldbörse aufladen",
        "pt": "Carteira de recarga",
        "ar": "رصيد المحفظة",
        "ko": "탑업 지갑"
      } +
      {
        "en": "Enter amount to top-up wallet with",
        "fr": "Saisissez le montant à recharger avec le portefeuille",
        "es": "Ingrese el monto para recargar la billetera con",
        "de":
            "Geben Sie den Betrag ein, mit dem die Brieftasche aufgeladen werden soll",
        "pt": "Insira o valor para recarregar a carteira com",
        "ar": "أدخل المبلغ لتعبئة المحفظة به",
        "ko": "충전 할 지갑 금액 입력"
      } +
      {
        "en": "Amount",
        "fr": "Montant",
        "es": "Monto",
        "de": "Menge",
        "pt": "Resultar",
        "ar": "كمية",
        "ko": "양"
      } +
      {
        "en": "TOP-UP",
        "fr": "REMPLIR",
        "es": "Recarga",
        "de": "NACHFÜLLEN",
        "pt": "COMPLETAR",
        "ar": "فوق حتى",
        "ko": "충전"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
