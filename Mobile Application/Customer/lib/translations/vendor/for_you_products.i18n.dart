import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "For You",
        "fr": "Pour vous",
        "es": "Para ti",
        "de": "Für dich",
        "pt": "Para você",
        "ar": "لك",
        "ko": "당신을 위해"
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
