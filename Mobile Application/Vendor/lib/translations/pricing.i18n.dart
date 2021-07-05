import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Products",
        "fr": "Des produits",
        "es": "Productos",
        "de": "Produkte",
        "pt": "Produtos",
        "ar": "منتجات",
        "ko": "제품"
      } +
      {
        "en": "Vendor",
        "fr": "Vendeur",
        "es": "Vendedor",
        "de": "Verkäufer",
        "pt": "Fornecedor",
        "ar": "بائع",
        "ko": "공급 업체"
      } +
      {
        "en": "Orders",
        "fr": "Ordres",
        "es": "Pedidos",
        "de": "Aufträge",
        "pt": "Pedidos",
        "ar": "أوامر",
        "ko": "명령"
      } +
      {
        "en": "More",
        "fr": "Suite",
        "es": "Más",
        "de": "Mehr",
        "pt": "Mais",
        "ar": "أكثر",
        "ko": "더"
      } +
      {
        "en": "Pricing",
        "fr": "Prix",
        "es": "Precios",
        "de": "Preisgestaltung",
        "pt": "Preços",
        "ar": "التسعير",
        "ko": "가격"
      } +
      {
        "en": "Package Type Pricing",
        "fr": "Type de forfait",
        "es": "Precio del tipo de paquete",
        "de": "Preis des Pakettyps",
        "pt": "Preço do tipo de pacote",
        "ar": "تسعير نوع الحزمة",
        "ko": "패키지 유형 가격"
      } +
      {
        "en": "Base Price",
        "fr": "Prix de base",
        "es": "Precio base",
        "de": "Grundpreis",
        "pt": "Preço base",
        "ar": "السعر الأساسي",
        "ko": "기본 가격"
      } +
      {
        "en": "Package Price",
        "fr": "Prix du coffret",
        "es": "Precio del paquete",
        "de": "Paketpreis",
        "pt": "Preço do pacote",
        "ar": "سعر الطرد",
        "ko": "패키지 가격"
      } +
      {
        "en": "Distance Price",
        "fr": "Prix à distance",
        "es": "Precio de distancia",
        "de": "Entfernungspreis",
        "pt": "Preço de distância",
        "ar": "سعر المسافة",
        "ko": "거리 가격"
      } +
      {
        "en": "Auto Ready",
        "fr": "Prêt automatique",
        "es": "Auto listo",
        "de": "Automatisch bereit",
        "pt": "Auto Ready",
        "ar": "جاهز تلقائي",
        "ko": "자동 준비"
      } +
      {
        "en": "Extra fields",
        "fr": "Champs supplémentaires",
        "es": "Campos adicionales",
        "de": "Zusätzliche Felder",
        "pt": "Campos extras",
        "ar": "حقول اضافية",
        "ko": "추가 필드"
      } +
      {
        "en": "Max booking days",
        "fr": "Jours de réservation max",
        "es": "Días máximos de reserva",
        "de": "Max. Buchungstage",
        "pt": "Máximo de dias de reserva",
        "ar": "ماكس أيام الحجز",
        "ko": "최대 예약일"
      } +
      {
        "en": "Activate",
        "fr": "Activer",
        "es": "Activar",
        "de": "aktivieren Sie",
        "pt": "Ativar",
        "ar": "تفعيل",
        "ko": "활성화"
      } +
      {
        "en": "Deactivate",
        "fr": "Désactiver",
        "es": "Desactivar",
        "de": "Deaktivieren",
        "pt": "Desativar",
        "ar": "تعطيل",
        "ko": "비활성화"
      } +
      {
        "en": "Are you sure you want to",
        "fr": "Êtes-vous sûr de vouloir",
        "es": "Estás seguro que quieres",
        "de": "Bist du sicher, dass du das willst",
        "pt": "Você tem certeza que quer",
        "ar": "هل أنت متأكد أنك تريد",
        "ko": "하시겠습니까?"
      } +
      {
        "en": "Status Update",
        "fr": "Mise à jour du statut",
        "es": "Actualización de estado",
        "de": "Status-Update",
        "pt": "Atualização de status",
        "ar": "تحديث الحالة",
        "ko": "상황 업데이트"
      } +
      {
        "en": "Deactivate",
        "fr": "Désactiver",
        "es": "Desactivar",
        "de": "Deaktivieren",
        "pt": "Desativar",
        "ar": "تعطيل",
        "ko": "비활성화"
      } +
      {
        "en": "Edit Package Type Pricing",
        "fr": "Modifier la tarification du type de package",
        "es": "Editar precio del tipo de paquete",
        "de": "Pakettyppreise bearbeiten",
        "pt": "Editar preços de tipo de pacote",
        "ar": "تحرير تسعير نوع الحزمة",
        "ko": "패키지 유형 가격 수정"
      } +
      {
        "en": "New Package Type Pricing",
        "fr": "Nouveau type de forfait",
        "es": "Precios del nuevo tipo de paquete",
        "de": "Preise für neue Pakettypen",
        "pt": "Novo preço de tipo de pacote",
        "ar": "تسعير نوع الحزمة الجديدة",
        "ko": "새로운 패키지 유형 가격"
      } +
      {
        "en": "Package Type",
        "fr": "Type d'emballage",
        "es": "Tipo de paquete",
        "de": "Pakettyp",
        "pt": "Tipo de Pacote",
        "ar": "نوع الحزمة",
        "ko": "포장 종류"
      } +
      {
        "en": "Select Package Type",
        "fr": "Sélectionnez le type de package",
        "es": "Seleccione el tipo de paquete",
        "de": "Pakettyp auswählen",
        "pt": "Selecione o tipo de pacote",
        "ar": "حدد نوع الحزمة",
        "ko": "패키지 유형 선택"
      } +
      {
        "en": "Update Pricing",
        "fr": "Mettre à jour les prix",
        "es": "Actualizar precios",
        "de": "Preise aktualisieren",
        "pt": "Atualizar preços",
        "ar": "تحديث التسعير",
        "ko": "가격 업데이트"
      } +
      {
        "en": "Successful",
        "fr": "À succès",
        "es": "Exitoso",
        "de": "Erfolgreich",
        "pt": "Bem sucedido",
        "ar": "ناجح",
        "ko": "성공한"
      } +
      {
        "en": "New Pricing",
        "fr": "Nouveau prix",
        "es": "Precios nuevos",
        "de": "Neue Preise",
        "pt": "Novo preço",
        "ar": "التسعير الجديد",
        "ko": "새로운 가격"
      } +
      {
        "en": "New Package Type Pricing",
        "fr": "Nouveau type de forfait",
        "es": "Precios del nuevo tipo de paquete",
        "de": "Preise für neue Pakettypen",
        "pt": "Novo preço de tipo de pacote",
        "ar": "تسعير نوع الحزمة الجديدة",
        "ko": "새로운 패키지 유형 가격"
      } +
      {
        "en": "Package Type",
        "fr": "Type d'emballage",
        "es": "Tipo de paquete",
        "de": "Pakettyp",
        "pt": "Tipo de Pacote",
        "ar": "نوع الحزمة",
        "ko": "포장 종류"
      } +
      {
        "en": "Select Package Type",
        "fr": "Sélectionnez le type de package",
        "es": "Seleccione el tipo de paquete",
        "de": "Pakettyp auswählen",
        "pt": "Selecione o tipo de pacote",
        "ar": "حدد نوع الحزمة",
        "ko": "패키지 유형 선택"
      } +
      {
        "en": "Save Pricing",
        "fr": "Économiser les prix",
        "es": "Ahorre precio",
        "de": "Preise speichern",
        "pt": "Economize preços",
        "ar": "حفظ التسعير",
        "ko": "가격 저장"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
