import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Settings",
        "fr": "Réglages",
        "es": "Ajustes",
        "de": "die Einstellungen",
        "pt": "Configurações",
        "ar": "إعدادات",
        "ko": "설정"
      } +
      {
        "en": "Profile & App Settings",
        "fr": "Paramètres de profil et d'application",
        "es": "Configuración de perfil y aplicación",
        "de": "Profil- und App-Einstellungen",
        "pt": "Configurações de perfil e aplicativo",
        "ar": "الملف الشخصي وإعدادات التطبيق",
        "ko": "프로필 및 앱 설정"
      } +
      {
        "en": "Notifications",
        "fr": "Notifications",
        "es": "Notificaciones",
        "de": "Benachrichtigungen",
        "pt": "Notificações",
        "ar": "إشعارات",
        "ko": "알림"
      } +
      {
        "en": "Rate & Review",
        "fr": "Noter et revoir",
        "es": "Revisión de tasas",
        "de": "Bewerten & Bewerten",
        "pt": "Avaliar e comentar",
        "ar": "مراجعة معدل",
        "ko": "평가 및 검토"
      } +
      {
        "en": "Version",
        "fr": "Version",
        "es": "Versión",
        "de": "Ausführung",
        "pt": "Versão",
        "ar": "إصدار",
        "ko": "버전"
      } +
      {
        "en": "Privacy Policy",
        "fr": "Politique de confidentialité",
        "es": "Política de privacidad",
        "de": "Datenschutz-Bestimmungen",
        "pt": "Política de Privacidade",
        "ar": "سياسة خاصة",
        "ko": "개인 정보 정책"
      } +
      {
        "en": "Language",
        "fr": "Langue",
        "es": "Idioma",
        "de": "Sprache",
        "pt": "Língua",
        "ar": "لغة",
        "ko": "언어"
      } +
      {
        "en": "Copyright ©%s %s all right reserved",
        "fr": "Copyright ©%s %s tous droits réservés",
        "es": "Copyright ©%s %s todos los derechos reservados",
        "de": "Copyright ©%s %s Alle Rechte vorbehalten",
        "pt": "Copyright ©%s %s todos os direitos reservados",
        "ar": "حقوق النشر ©%s %s جميع الحقوق محفوظة",
        "ko": "Copyright ©%s %s all right reserved"
      } +
      {
        "en": "Copyright ©%s %s all right reserved",
        "fr": "Copyright ©%s %s tous droits réservés",
        "es": "Copyright ©%s %s todos los derechos reservados",
        "de": "Copyright ©%s %s Alle Rechte vorbehalten",
        "pt": "Copyright ©%s %s todos os direitos reservados",
        "ar": "حقوق التأليف والنشر %s %s© جميع الحقوق محفوظة",
        "ko": "저작권 ©%s %s 모든 권리 보유"
      } +
      {
        "en": "Edit Profile",
        "fr": "Editer le profil",
        "es": "Editar perfil",
        "de": "Profil bearbeiten",
        "pt": "Editar Perfil",
        "ar": "تعديل الملف الشخصي",
        "ko": "프로필 수정"
      } +
      {
        "en": "Delivery Addresses",
        "fr": "Adresses de livraison",
        "es": "Direcciones de entrega",
        "de": "Lieferadressen",
        "pt": "Endereços de entrega",
        "ar": "عناوين التسليم",
        "ko": "배송 주소"
      } +
      {
        "en": "Favourites",
        "fr": "Favoris",
        "es": "Favoritos",
        "de": "Favoriten",
        "pt": "Favoritos",
        "ar": "المفضلة",
        "ko": "즐겨 찾기"
      } +
      {
        "en": "Logout",
        "fr": "Se déconnecter",
        "es": "Cerrar sesión",
        "de": "Ausloggen",
        "pt": "Sair",
        "ar": "تسجيل خروج",
        "ko": "로그 아웃"
      } +
      {
        "en": "Wallet",
        "fr": "Portefeuille",
        "es": "Cartera",
        "de": "Brieftasche",
        "pt": "Carteira",
        "ar": "محفظة",
        "ko": "지갑"
      } +
      {
        "en": "Change Password",
        "fr": "Changer le mot de passe",
        "es": "Cambiar la contraseña",
        "de": "Kennwort ändern",
        "pt": "Alterar a senha",
        "ar": "تغيير كلمة المرور",
        "ko": "비밀번호 변경"
      } +
      {
        "en": "Current Password",
        "fr": "Mot de passe actuel",
        "es": "Contraseña actual",
        "de": "Jetziges Passwort",
        "pt": "Senha atual",
        "ar": "كلمة السر الحالية",
        "ko": "현재 비밀번호"
      } +
      {
        "en": "New Password",
        "fr": "nouveau mot de passe",
        "es": "Nueva contraseña",
        "de": "Neues Kennwort",
        "pt": "Nova Senha",
        "ar": "كلمة السر الجديدة",
        "ko": "새 비밀번호"
      } +
      {
        "en": "Confirm New Password",
        "fr": "Confirmer le nouveau mot de passe",
        "es": "Confirmar nueva contraseña",
        "de": "Bestätige neues Passwort",
        "pt": "Confirme a nova senha",
        "ar": "تأكيد كلمة المرور الجديدة",
        "ko": "새 암호를 확인합니다"
      } +
      {
        "en": "Update Password",
        "fr": "Mettre à jour le mot de passe",
        "es": "Actualiza contraseña",
        "de": "Passwort erneuern",
        "pt": "Atualizar senha",
        "ar": "تطوير كلمة السر",
        "ko": "비밀번호 업데이트"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
