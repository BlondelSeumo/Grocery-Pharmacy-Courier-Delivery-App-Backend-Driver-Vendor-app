import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "You have to login to access profile and history",
        "fr":
            "Vous devez vous connecter pour accéder au profil et à l'historique",
        "es": "Tienes que iniciar sesión para acceder al perfil y al historial",
        "de":
            "Sie müssen sich anmelden, um auf Profil und Verlauf zugreifen zu können",
        "pt": "Você precisa fazer o login para acessar o perfil e o histórico",
        "ar": "يجب عليك تسجيل الدخول للوصول إلى الملف الشخصي والتاريخ",
        "ko": "프로필 및 기록에 액세스하려면 로그인해야합니다."
      } +
      {
        "en": "Login",
        "fr": "Connexion",
        "es": "Acceso",
        "de": "Anmeldung",
        "pt": "Conecte-se",
        "ar": "تسجيل الدخول",
        "ko": "로그인"
      };

  String get i18n => localize(this, _t);
}
