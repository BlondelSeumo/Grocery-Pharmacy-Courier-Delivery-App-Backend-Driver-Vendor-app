import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Reset Password",
        "fr": "réinitialiser le mot de passe",
        "es": "Restablecer la contraseña",
        "de": "Passwort zurücksetzen",
        "pt": "Redefinir senha",
        "ar": "إعادة تعيين كلمة المرور",
        "ko": "암호를 재설정"
      } +
      {
        "en": "Forgot Password",
        "fr": "Mot de passe oublié",
        "es": "Has olvidado tu contraseña",
        "de": "Passwort vergessen",
        "pt": "Esqueceu a senha",
        "ar": "هل نسيت كلمة السر",
        "ko": "비밀번호를 잊으 셨나요"
      } +
      {
        "en": "Phone Number",
        "fr": "Numéro de téléphone",
        "es": "Número de teléfono",
        "de": "Telefonnummer",
        "pt": "Número de telefone",
        "ar": "رقم التليفون",
        "ko": "전화 번호"
      } +
      {
        "en": "Send OTP",
        "fr": "Envoyer OTP",
        "es": "Enviar OTP",
        "de": "OTP senden",
        "pt": "Enviar OTP",
        "ar": "أرسل OTP",
        "ko": "OTP 보내기"
      } +
      {
        "en": "Reset Password",
        "fr": "réinitialiser le mot de passe",
        "es": "Restablecer la contraseña",
        "de": "Passwort zurücksetzen",
        "pt": "Redefinir senha",
        "ar": "إعادة تعيين كلمة المرور",
        "ko": "암호를 재설정"
      } +
      {
        "en": "Invalid Phone Number",
        "fr": "Numéro de téléphone invalide",
        "es": "Numero de telefono invalido",
        "de": "Ungültige Telefonnummer",
        "pt": "Número de telefone inválido",
        "ar": "رقم الهاتف غير صحيح",
        "ko": "유효하지 않은 전화 번호"
      } +
      {
        "en": "New Password",
        "fr": "nouveau mot de passe",
        "es": "Nueva contraseña",
        "de": "Neues Passwort",
        "pt": "Nova Senha",
        "ar": "كلمة السر الجديدة",
        "ko": "새 비밀번호"
      } +
      {
        "en": "Reset Password",
        "fr": "réinitialiser le mot de passe",
        "es": "Restablecer la contraseña",
        "de": "Passwort zurücksetzen",
        "pt": "Redefinir senha",
        "ar": "إعادة تعيين كلمة المرور",
        "ko": "암호를 재설정"
      } +
      {
        "en": "Please enter account new password",
        "fr": "Veuillez saisir le nouveau mot de passe du compte",
        "es": "Ingrese la nueva contraseña de la cuenta",
        "de": "Bitte geben Sie ein neues Passwort für das Konto ein",
        "pt": "Por favor, insira a nova senha da conta",
        "ar": "الرجاء إدخال كلمة المرور الجديدة للحساب",
        "ko": "계정 새 비밀번호를 입력하십시오"
      };

  String get i18n => localize(this, _t);
}
