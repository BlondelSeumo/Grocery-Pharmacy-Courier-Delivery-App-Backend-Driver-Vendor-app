import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Did you like provided service?",
        "fr": "Avez-vous aimé le service fourni?",
        "es": "¿Le gustó el servicio proporcionado?",
        "de": "Hat Ihnen der angebotene Service gefallen?",
        "pt": "Gostou do serviço prestado?",
        "ar": "هل تحب الخدمة المقدمة؟",
        "ko": "제공된 서비스가 마음에 드셨습니까?"
      } +
      {
        "en": "Submit",
        "fr": "Nous faire parvenir",
        "es": "Enviar",
        "de": "einreichen",
        "pt": "Enviar",
        "ar": "يقدم",
        "ko": "제출"
      } +
      {
        "en": "Comment",
        "fr": "Commenter",
        "es": "Comentario",
        "de": "Kommentar",
        "pt": "Comente",
        "ar": "تعليق",
        "ko": "논평"
      } +
      {
        "en": "Vendor Rating",
        "fr": "Note fournisseur",
        "es": "Calificación de proveedor",
        "de": "Lieferantenbewertung",
        "pt": "Classificação do vendedor",
        "ar": "تصنيفهم",
        "ko": "공급 업체 등급"
      } +
      {
        "en": "Driver Rating",
        "fr": "Évaluation du conducteur",
        "es": "Calificación del conductor",
        "de": "Fahrerbewertung",
        "pt": "Avaliação do motorista",
        "ar": "تقييم السائق",
        "ko": "운전자 평가"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
