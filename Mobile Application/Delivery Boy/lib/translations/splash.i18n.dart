import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Loading Please wait...",
        "fr": "Chargement, veuillez patienter...",
        "es": "Cargando por favor espere...",
        "de": "Laden, bitte warten...",
        "pt": "Carregando, por favor espere...",
        "ar": "جاري التحميل الرجاءالانتظار...",
        "ko": "로딩 중 기다려주세요..."
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
