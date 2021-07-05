import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Categories",
        "fr": "Catégories",
        "es": "Categorias",
        "de": "Kategorien",
        "pt": "Categorias",
        "ar": "فئات",
        "ko": "카테고리"
      };

  String get i18n => localize(this, _t);
}
