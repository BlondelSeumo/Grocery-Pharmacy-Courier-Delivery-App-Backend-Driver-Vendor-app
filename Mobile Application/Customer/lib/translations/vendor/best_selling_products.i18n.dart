import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Best Selling",
        "fr": "Meilleure vente",
        "es": "Más vendido",
        "de": "Meistverkauft",
        "pt": "Mais Vendido",
        "ar": "أفضل مبيعات",
        "ko": "가장 잘 팔리는"
      } +
      {
        "en": "See all",
        "fr": "Voir tout",
        "es": "Ver todo",
        "de": "Alles sehen",
        "pt": "Ver tudo",
        "ar": "اظهار الكل",
        "ko": "모두보기"
      };

  String get i18n => localize(this, _t);
}
