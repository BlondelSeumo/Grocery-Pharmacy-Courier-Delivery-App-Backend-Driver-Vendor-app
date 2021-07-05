import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Order Details",
        "fr": "détails de la commande",
        "es": "Detalles del pedido",
        "de": "Bestelldetails",
        "pt": "detalhes do pedido",
        "ar": "تفاصيل الطلب",
        "ko": "주문 정보"
      } +
      {
        "en": "Deliver To",
        "fr": "Livrer à",
        "es": "Entregar a",
        "de": "Liefern an",
        "pt": "Entregar para",
        "ar": "يسلم إلى",
        "ko": "배달"
      } +
      {
        "en": "Customer Order Pickup",
        "fr": "Ramassage de la commande client",
        "es": "Recogida de pedidos del cliente",
        "de": "Abholung von Kundenaufträgen",
        "pt": "Retirada de pedido do cliente",
        "ar": "استلام طلب العميل",
        "ko": "고객 주문 픽업"
      } +
      {
        "en": "Status",
        "fr": "Statut",
        "es": "Estado",
        "de": "Status",
        "pt": "Status",
        "ar": "حالة",
        "ko": "상태"
      } +
      {
        "en": "Payment Status",
        "fr": "Statut de paiement",
        "es": "Estado de pago",
        "de": "Zahlungsstatus",
        "pt": "Status do pagamento",
        "ar": "حالة السداد",
        "ko": "지불 상태"
      } +
      {
        "en": "PAY FOR ORDER",
        "fr": "PAYER LA COMMANDE",
        "es": "PAGO POR ORDEN",
        "de": "FÜR EINE BESTELLUNG BEZAHLEN",
        "pt": "PAGAR PELO PEDIDO",
        "ar": "دفع ثمن ذلك",
        "ko": "주문 결제"
      } +
      {
        "en": "Code",
        "fr": "Code",
        "es": "Código",
        "de": "Code",
        "pt": "Código",
        "ar": "رمز",
        "ko": "암호"
      } +
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
        "en": "Driver",
        "fr": "Chauffeur",
        "es": "Conductor",
        "de": "Treiber",
        "pt": "Motorista",
        "ar": "سائق",
        "ko": "운전사"
      } +
      {
        "en": "Note",
        "fr": "Noter",
        "es": "Nota",
        "de": "Hinweis",
        "pt": "Observação",
        "ar": "ملحوظة",
        "ko": "노트"
      } +
      {
        "en": "Chat with vendor",
        "fr": "Discuter avec le fournisseur",
        "es": "Chatear con el proveedor",
        "de": "Chatten Sie mit dem Anbieter",
        "pt": "Converse com o fornecedor",
        "ar": "الدردشة مع البائع",
        "ko": "공급 업체와 채팅"
      } +
      {
        "en": "Chat with driver",
        "fr": "Discuter avec le chauffeur",
        "es": "Chatear con el conductor",
        "de": "Chatten Sie mit dem Fahrer",
        "pt": "Converse com o motorista",
        "ar": "الدردشة مع السائق",
        "ko": "운전 기사와 채팅"
      } +
      {
        "en": "Chat with",
        "fr": "Parler avec",
        "es": "Chatear con",
        "de": "Plaudern mit",
        "pt": "Conversar com",
        "ar": "الدردشة مع",
        "ko": "채팅"
      } +
      {
        "en": "Pickup Location",
        "fr": "Lieu de ramassage",
        "es": "Lugar de recogida",
        "de": "Treffpunkt",
        "pt": "Local de coleta",
        "ar": "اختر موقعا",
        "ko": "짐을 싣는 곳"
      } +
      {
        "en": "Dropoff Location",
        "fr": "Point de chute",
        "es": "Punto de entrega",
        "de": "Rückgabestation",
        "pt": "Local de entrega",
        "ar": "موقع الإنزال",
        "ko": "반납 장소"
      } +
      {
        "en": "Package Details",
        "fr": "Détails du package",
        "es": "Detalles del paquete",
        "de": "Paketdetails",
        "pt": "Detalhes de embalagem",
        "ar": "حزمة من التفاصيل",
        "ko": "패키지 세부 정보"
      } +
      {
        "en": "Width",
        "fr": "Largeur",
        "es": "Ancho",
        "de": "Breite",
        "pt": "Largura",
        "ar": "عرض",
        "ko": "폭"
      } +
      {
        "en": "Length",
        "fr": "Longueur",
        "es": "Largo",
        "de": "Länge",
        "pt": "Comprimento",
        "ar": "طول",
        "ko": "길이"
      } +
      {
        "en": "Height",
        "fr": "Hauteur",
        "es": "Altura",
        "de": "Höhe",
        "pt": "Altura",
        "ar": "ارتفاع",
        "ko": "신장"
      } +
      {
        "en": "Weight",
        "fr": "Poids",
        "es": "Peso",
        "de": "Gewicht",
        "pt": "Peso",
        "ar": "وزن",
        "ko": "무게"
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
        "en": "Recipient Name",
        "fr": "Nom du destinataire",
        "es": "Nombre del Recipiente",
        "de": "Name des Empfängers",
        "pt": "Nome do Destinatário",
        "ar": "اسم المستلم",
        "ko": "받는 사람 이름"
      } +
      {
        "en": "Recipient Phone",
        "fr": "Téléphone du destinataire",
        "es": "Teléfono del destinatario",
        "de": "Empfängertelefon",
        "pt": "Telefone Destinatário",
        "ar": "هاتف المستلم",
        "ko": "수신자 전화"
      } +
      {
        "en": "Rate The Vendor",
        "fr": "Évaluez le fournisseur",
        "es": "Califica al vendedor",
        "de": "Bewerten Sie den Anbieter",
        "pt": "Avalie o fornecedor",
        "ar": "قيم البائع",
        "ko": "공급 업체 평가"
      } +
      {
        "en": "Call vendor",
        "fr": "Appeler le vendeur",
        "es": "Llamar al proveedor",
        "de": "Rufen Sie den Anbieter an",
        "pt": "Ligue para o vendedor",
        "ar": "اتصل بالبائع",
        "ko": "공급 업체에 전화"
      } +
      {
        "en": "Track Order",
        "fr": "Suivi de commande",
        "es": "Orden de pista",
        "de": "Bestellung verfolgen",
        "pt": "Acompanhar Pedido",
        "ar": "ترتيب المسار",
        "ko": "주문을 추적하다"
      } +
      {
        "en": "Order Tracking",
        "fr": "Suivi de commande",
        "es": "Rastreo de orden",
        "de": "Sendungsverfolgung",
        "pt": "Rastreamento de pedido",
        "ar": "تتبع الطلب",
        "ko": "주문 추적"
      } +
      {
        "en": "Verification Code",
        "fr": "Code de vérification",
        "es": "Código de verificación",
        "de": "Verifizierungs-Schlüssel",
        "pt": "Código de verificação",
        "ar": "شيفرة التأكيد",
        "ko": "확인 코드"
      } +
      {
        "en": "Cancel Order",
        "fr": "annuler la commande",
        "es": "Cancelar orden",
        "de": "Bestellung stornieren",
        "pt": "Cancelar pedido",
        "ar": "الغاء الطلب",
        "ko": "주문 취소"
      } +
      {
        "en": "Order Cancellation",
        "fr": "Annulation de la commande",
        "es": "Cancelación de orden",
        "de": "Auftragsstornierung",
        "pt": "Cancelamento de pedido",
        "ar": "طلب الغاء",
        "ko": "주문 취소"
      } +
      {
        "en": "Please state why you want to cancel order",
        "fr": "Veuillez indiquer pourquoi vous souhaitez annuler la commande",
        "es": "Indique por qué desea cancelar el pedido.",
        "de": "Bitte geben Sie an, warum Sie die Bestellung stornieren möchten",
        "pt": "Por favor, indique porque você deseja cancelar o pedido",
        "ar": "يرجى ذكر سبب رغبتك في إلغاء الطلب",
        "ko": "주문을 취소하려는 이유를 명시하십시오."
      } +
      {
        "en": "Long pickup time",
        "fr": "Temps de ramassage long",
        "es": "Tiempo de recogida prolongado",
        "de": "Lange Abholzeit",
        "pt": "Tempo de coleta longo",
        "ar": "وقت طويل",
        "ko": "긴 픽업 시간"
      } +
      {
        "en": "Vendor is too slow",
        "fr": "Le fournisseur est trop lent",
        "es": "El vendedor es demasiado lento",
        "de": "Verkäufer ist zu langsam",
        "pt": "Vendedor é muito lento",
        "ar": "البائع بطيء جدًا",
        "ko": "공급 업체가 너무 느립니다."
      } +
      {
        "en": "custom",
        "fr": "Douane",
        "es": "personalizado",
        "de": "Benutzerdefiniert",
        "pt": "personalizadas",
        "ar": "العادة",
        "ko": "커스텀"
      } +
      {
        "en": "Reason",
        "fr": "Raison",
        "es": "Razón",
        "de": "Grund",
        "pt": "Razão",
        "ar": "سبب",
        "ko": "이유"
      } +
      {
        "en": "Submit",
        "fr": "Soumettre",
        "es": "Enviar",
        "de": "einreichen",
        "pt": "Enviar",
        "ar": "إرسال",
        "ko": "제출"
      } +
      {
        "en": "Scheduled Date",
        "fr": "Date prévue",
        "es": "Cita agendada",
        "de": "Geplantes Datum",
        "pt": "Data marcada",
        "ar": "التاريخ المقرر",
        "ko": "예정일"
      } +
      {
        "en": "Scheduled Time",
        "fr": "Heure prévue",
        "es": "Hora programada",
        "de": "Geplante Zeit",
        "pt": "Horário marcado",
        "ar": "جدول زمني",
        "ko": "예정된 시간"
      } +
      {
        "en": "Stop",
        "fr": "Arrêter",
        "es": "Detener",
        "de": "Halt",
        "pt": "Pare",
        "ar": "قف",
        "ko": "중지"
      } +
      {
        "en": "Rate The Driver",
        "fr": "Évaluez le conducteur",
        "es": "Califica al conductor",
        "de": "Bewerten Sie den Treiber",
        "pt": "Avalie o motorista",
        "ar": "قيم السائق",
        "ko": "드라이버 평가"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
