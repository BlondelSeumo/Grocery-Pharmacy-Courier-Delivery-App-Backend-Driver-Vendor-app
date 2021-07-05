import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Join Us",
        "fr": "Rejoignez-nous",
        "es": "Únete a nosotros",
        "de": "Begleiten Sie uns",
        "pt": "Junte-se a nós",
        "ar": "انضم إلينا",
        "ko": "우리와 함께"
      } +
      {
        "en": "Create an account now",
        "fr": "Créez un compte maintenant",
        "es": "Crea una cuenta ahora",
        "de": "Erstellen Sie jetzt ein Konto",
        "pt": "Crie uma conta agora",
        "ar": "قم بإنشاء حساب الآن",
        "ko": "지금 계정 만들기"
      } +
      {
        "en": "Name",
        "fr": "Nom",
        "es": "Nombre",
        "de": "Name",
        "pt": "Nome",
        "ar": "اسم",
        "ko": "이름"
      } +
      {
        "en": "Phone",
        "fr": "Téléphone",
        "es": "Teléfono",
        "de": "Telefon",
        "pt": "Telefone",
        "ar": "هاتف",
        "ko": "전화"
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
        "en": "Create Account",
        "fr": "Créer un compte",
        "es": "Crear una cuenta",
        "de": "Konto erstellen",
        "pt": "Criar uma conta",
        "ar": "إنشاء حساب",
        "ko": "계정 생성"
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
        "en": "Already have an Account",
        "fr": "Vous avez déjà un compte",
        "es": "Ya tienes una cuenta",
        "de": "Sie haben bereits ein Konto",
        "pt": "Já tem uma conta",
        "ar": "هل لديك حساب",
        "ko": "이미 계정이 있습니다"
      } +
      {
        "en": "Verify your phone number",
        "fr": "Vérifiez votre numéro de téléphone",
        "es": "verifica tu numero de telefono",
        "de": "Bestätige deine Telefonnummer",
        "pt": "verifique seu número de telefone",
        "ar": "اكد على رقم هاتفك او جوالك",
        "ko": "전화 번호 확인"
      } +
      {
        "en": "Enter otp sent to your provided phone number",
        "fr": "Entrez otp envoyé à votre numéro de téléphone fourni",
        "es": "Ingrese otp enviado a su número de teléfono proporcionado",
        "de":
            "Geben Sie otp ein, das an Ihre angegebene Telefonnummer gesendet wurde",
        "pt": "Digite otp enviado para o número de telefone fornecido",
        "ar": "أدخل otp المرسل إلى رقم هاتفك المقدم",
        "ko": "제공된 전화 번호로 전송 된 OTP를 입력하세요."
      } +
      {
        "en": "Verify",
        "fr": "Vérifier",
        "es": "Verificar",
        "de": "Überprüfen",
        "pt": "Verificar",
        "ar": "التحقق",
        "ko": "확인"
      } +
      {
        "en": "Registration Failed",
        "fr": "Échec de l'enregistrement",
        "es": "Registro fallido",
        "de": "Registrierung fehlgeschlagen",
        "pt": "Registração falhou",
        "ar": "فشل في التسجيل",
        "ko": "등록 실패"
      };

  String get i18n => localize(this, _t);
}
