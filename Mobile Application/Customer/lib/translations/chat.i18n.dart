import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Type here",
        "fr": "Écrivez ici",
        "es": "Escriba aquí",
        "de": "Geben Sie hier ein",
        "pt": "Digite aqui",
        "ar": "أكتب هنا",
        "ko": "여기에 입력"
      } +
      {
        "en": "Welcome",
        "fr": "Bienvenue",
        "es": "Bienvenida",
        "de": "Herzlich willkommen",
        "pt": "Receber",
        "ar": "أهلا بك",
        "ko": "어서 오십시오"
      } +
      {
        "en": "Something wrong",
        "fr": "Quelque chose ne va pas",
        "es": "Algo mal",
        "de": "Etwas stimmt nicht",
        "pt": "Algo errado",
        "ar": "هل هناك خطب ما",
        "ko": "뭔가 잘못"
      } +
      {
        "en": "New Message from",
        "fr": "Nouveau message de",
        "es": "Nuevo mensaje de",
        "de": "Neue Nachricht von",
        "pt": "Nova Mensagem de",
        "ar": "رسالة جديدة من",
        "ko": "새 메시지"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
