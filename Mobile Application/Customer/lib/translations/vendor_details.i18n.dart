import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Description",
        "fr": "Description",
        "es": "Descripción",
        "de": "Beschreibung",
        "pt": "Descrição",
        "ar": "وصف",
        "ko": "기술"
      } +
      {
        "en": "Address",
        "fr": "Adresse",
        "es": "Dirección",
        "de": "Adresse",
        "pt": "Endereço",
        "ar": "تبوك",
        "ko": "주소"
      } +
      {
        "en": "Phone",
        "fr": "Téléphone",
        "es": "Teléfono",
        "de": "Telefon",
        "pt": "Telefone",
        "ar": "هاتف",
        "ko": "전화"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
