import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Profile Update",
        "fr": "Mise à jour du profil",
        "es": "Actualización de perfil",
        "de": "Profilaktualisierung",
        "pt": "Atualização de Perfil",
        "ar": "تحديث الملف الشخصي",
        "ko": "프로필 업데이트"
      } +
      {
        "en": "Registration Failed",
        "fr": "Échec de l'enregistrement",
        "es": "Registro fallido",
        "de": "Registrierung fehlgeschlagen",
        "pt": "Registração falhou",
        "ar": "فشل في التسجيل",
        "ko": "등록 실패"
      } +
      {
        "en": "Login Failed",
        "fr": "Échec de la connexion",
        "es": "Error de inicio de sesion",
        "de": "Fehler bei der Anmeldung",
        "pt": "Falha no login",
        "ar": "فشل تسجيل الدخول",
        "ko": "로그인 실패"
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
        "en": "Are you sure you want to logout?",
        "fr": "Êtes-vous sûr de vouloir vous déconnecter?",
        "es": "¿Está seguro de que desea cerrar la sesión?",
        "de": "Möchten Sie sich abmelden?",
        "pt": "Tem certeza que deseja sair?",
        "ar": "هل أنت متأكد أنك تريد تسجيل الخروج؟",
        "ko": "로그 아웃 하시겠습니까?"
      } +
      {
        "en": "Logging out Please wait...",
        "fr": "Déconnexion Veuillez patienter ...",
        "es": "Cerrar sesión Espere ...",
        "de": "Abmelden Bitte warten ...",
        "pt": "Saindo Por favor, aguarde ...",
        "ar": "تسجيل الخروج الرجاء الانتظار ...",
        "ko": "로그 아웃 잠시만 기다려주십시오 ..."
      } +
      {
        "en": "Add to cart",
        "fr": "Ajouter au panier",
        "es": "Añadir a la cesta",
        "de": "In den Warenkorb legen",
        "pt": "Adicionar ao Carrinho",
        "ar": "أضف إلى السلة",
        "ko": "장바구니에 담기"
      } +
      {
        "en": "%s Added to cart",
        "fr": "%s ajouté au panier",
        "es": "%s añadido al carrito",
        "de": "%s In den Warenkorb gelegt",
        "pt": "%s adicionado ao carrinho",
        "ar": "تمت إضافة ٪s إلى سلة التسوق",
        "ko": "%s 카트에 추가됨"
      } +
      {
        "en": "Diifferent Vendor",
        "fr": "Fournisseur différent",
        "es": "Proveedor diferente",
        "de": "Unterschiedlicher Anbieter",
        "pt": "Fornecedor Diferente",
        "ar": "بائع مختلف",
        "ko": "다른 공급 업체"
      } +
      {
        "en":
            "Are you sure you'd like to change vendors? Your current items in cart will be lost.",
        "fr":
            "Voulez-vous vraiment changer de fournisseur? Vos articles actuels dans le panier seront perdus.",
        "es":
            "¿Está seguro de que le gustaría cambiar de proveedor? Se perderán sus artículos actuales en el carrito.",
        "de":
            "Sind Sie sicher, dass Sie den Anbieter wechseln möchten? Ihre aktuellen Artikel im Warenkorb gehen verloren.",
        "pt":
            "Tem certeza de que deseja mudar de fornecedor? Seus itens atuais no carrinho serão perdidos.",
        "ar":
            "هل أنت متأكد أنك تريد تغيير البائعين؟ ستفقد العناصر الحالية في عربة التسوق.",
        "ko": "공급 업체를 변경 하시겠습니까? 장바구니에있는 현재 항목이 손실됩니다."
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
