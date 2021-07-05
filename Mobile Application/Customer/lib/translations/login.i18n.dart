import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Welcome Back",
        "fr": "Content de te revoir",
        "es": "Bienvenido de nuevo",
        "de": "Willkommen zurück",
        "pt": "Bem vindo de volta",
        "ar": "مرحبا بعودتك",
        "ko": "환영합니다"
      } +
      {
        "en": "Login to continue",
        "fr": "Connectez-vous pour continuer",
        "es": "Iniciar sesión para continuar",
        "de": "Melden Sie sich an, um fortzufahren",
        "pt": "Faça login para continuar",
        "ar": "تسجيل الدخول للمتابعة",
        "ko": "계속하려면 로그인"
      } +
      {
        "en": "Password",
        "fr": "Mot de passe",
        "es": "Contraseña",
        "de": "Passwort",
        "pt": "Senha",
        "ar": "كلمة المرور",
        "ko": "암호"
      } +
      {
        "en": "Forgot Password ?",
        "fr": "Mot de passe oublié ?",
        "es": "Has olvidado tu contraseña ?",
        "de": "Passwort vergessen ?",
        "pt": "Esqueceu a senha ?",
        "ar": "هل نسيت كلمة السر ؟",
        "ko": "비밀번호를 잊으 셨나요 ?"
      } +
      {
        "en": "Login",
        "fr": "Connexion",
        "es": "Acceso",
        "de": "Anmeldung",
        "pt": "Conecte-se",
        "ar": "تسجيل الدخول",
        "ko": "로그인"
      } +
      {
        "en": "OR",
        "fr": "OU",
        "es": "O",
        "de": "ODER",
        "pt": "OU",
        "ar": "أو",
        "ko": "또는"
      } +
      {
        "en": "Create An Account",
        "fr": "Créer un compte",
        "es": "Crea una cuenta",
        "de": "Ein Konto erstellen",
        "pt": "Crie a sua conta aqui",
        "ar": "انشئ حساب",
        "ko": "계정 생성"
      };

  String get i18n => localize(this, _t);
}
