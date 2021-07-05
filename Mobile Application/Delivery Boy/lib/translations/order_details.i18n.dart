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
        "en": "Customer",
        "fr": "Client",
        "es": "Cliente",
        "de": "Kunde",
        "pt": "Cliente",
        "ar": "عميل",
        "ko": "고객"
      } +
      {
        "en": "Chat with customer",
        "fr": "Discuter avec le client",
        "es": "Chatear con el cliente",
        "de": "Chatten Sie mit dem Kunden",
        "pt": "Converse com o cliente",
        "ar": "الدردشة مع العملاء",
        "ko": "고객과 채팅"
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
        "en": "Swipe To Complete",
        "fr": "Glisser pour terminer",
        "es": "Deslizar para completar",
        "de": "Zum Abschluss wischen",
        "pt": "Deslize para completar",
        "ar": "انتقد لإكمال",
        "ko": "완료하려면 스 와이프"
      } +
      {
        "en": "Swipe To Start",
        "fr": "Faites glisser pour commencer",
        "es": "Deslizar para comenzar",
        "de": "Wischen Sie zum Starten",
        "pt": "Deslize para começar",
        "ar": "انتقد للبدء",
        "ko": "시작하려면 스 와이프"
      } +
      {
        "en": "Vendor Address",
        "fr": "Adresse du fournisseur",
        "es": "Dirección del vendedor",
        "de": "Lieferantenadresse",
        "pt": "Endereço do Vendedor",
        "ar": "عنوان البائع",
        "ko": "공급 업체 주소"
      } +
      {
        "en": "Long Press To Start",
        "fr": "Appuyez longuement pour commencer",
        "es": "Pulsación larga para empezar",
        "de": "Lang drücken, um zu starten",
        "pt": "Pressione longamente para começar",
        "ar": "اضغط لفترة طويلة لبدء",
        "ko": "시작하려면 길게 누르기"
      } +
      {
        "en": "Long Press To Complete",
        "fr": "Appui long pour terminer",
        "es": "Pulsación larga para completar",
        "de": "Zum Drücken lange drücken",
        "pt": "Pressione longamente para concluir",
        "ar": "اضغط لفترة طويلة للإكمال",
        "ko": "완료하려면 길게 누르세요."
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
        "en": "Please enter verification code provided by the customer.",
        "fr": "Veuillez saisir le code de vérification fourni par le client.",
        "es": "Ingrese el código de verificación proporcionado por el cliente.",
        "de":
            "Bitte geben Sie den vom Kunden bereitgestellten Bestätigungscode ein.",
        "pt":
            "Por favor, insira o código de verificação fornecido pelo cliente.",
        "ar": "الرجاء إدخال رمز التحقق المقدم من قبل العميل.",
        "ko": "고객이 제공 한 인증 코드를 입력하십시오."
      } +
      {
        "en": "Verify",
        "fr": "Vérifier",
        "es": "Verificar",
        "de": "Überprüfen",
        "pt": "Verificar",
        "ar": "تحقق",
        "ko": "검증"
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
        "en": "Scan Verification Code",
        "fr": "Scannez le code de vérification",
        "es": "Escanear código de verificación",
        "de": "Scan-Bestätigungscode",
        "pt": "Código de verificação de digitalização",
        "ar": "مسح رمز التحقق",
        "ko": "확인 코드 스캔"
      } +
      {
        "en": "Payment Method",
        "fr": "Mode de paiement",
        "es": "Método de pago",
        "de": "Zahlungsmethode",
        "pt": "Forma de pagamento",
        "ar": "طريقة الدفع او السداد",
        "ko": "결제 방법"
      } +
      {
        "en": "Stop",
        "fr": "Arrêter",
        "es": "Detener",
        "de": "Halt",
        "pt": "Pare",
        "ar": "قف",
        "ko": "중지"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
