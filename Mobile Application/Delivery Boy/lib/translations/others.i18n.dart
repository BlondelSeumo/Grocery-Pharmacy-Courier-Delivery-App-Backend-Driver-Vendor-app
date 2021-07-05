import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Select Image",
        "fr": "Sélectionnez une image",
        "es": "Seleccionar imagen",
        "de": "Bild auswählen",
        "pt": "Selecione a imagem",
        "ar": "اختر صورة",
        "ko": "이미지 선택"
      } +
      {
        "en": "Remove",
        "fr": "Supprimer",
        "es": "Eliminar",
        "de": "Entfernen",
        "pt": "Retirar",
        "ar": "يزيل",
        "ko": "없애다"
      };

  String get i18n => localize(this, _t);
}
