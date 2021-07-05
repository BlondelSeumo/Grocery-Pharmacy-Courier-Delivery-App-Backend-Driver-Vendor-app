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
        "en": "Driver",
        "fr": "Conducteur",
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
        "en": "Chat with driver",
        "fr": "Discuter avec le chauffeur",
        "es": "Chatear con el conductor",
        "de": "Chatten Sie mit dem Fahrer",
        "pt": "Converse com o motorista",
        "ar": "الدردشة مع السائق",
        "ko": "운전 기사와 채팅"
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
        "en": "Edit",
        "fr": "Éditer",
        "es": "Editar",
        "de": "Bearbeiten",
        "pt": "Editar",
        "ar": "يحرر",
        "ko": "편집하다"
      } +
      {
        "en": "Cancel",
        "fr": "Annuler",
        "es": "Cancelar",
        "de": "Stornieren",
        "pt": "Cancelar",
        "ar": "يلغي",
        "ko": "취소"
      } +
      {
        "en": "Order Status",
        "fr": "Statut de la commande",
        "es": "Estado de la orden",
        "de": "Bestellstatus",
        "pt": "Status do pedido",
        "ar": "حالة الطلب",
        "ko": "주문 상태"
      } +
      {
        "en":
            "You are about to change this order status to %s. Do you want to continue?",
        "fr":
            "Vous êtes sur le point de changer l'état de cette commande en %s. Voulez-vous continuer?",
        "es":
            "Está a punto de cambiar el estado de este pedido a %s. ¿Quieres continuar?",
        "de":
            "Sie werden diesen Bestellstatus in %s ändern. Möchtest du fortfahren?",
        "pt":
            "Você está prestes a alterar o status do pedido para %s. Você quer continuar?",
        "ar": "أنت على وشك تغيير حالة الطلب هذه إلى %s. هل تريد الاستمرار؟",
        "ko": "이 주문 상태를 %s (으)로 변경하려고합니다. 계속 하시겠습니까?"
      } +
      {
        "en": "cancelled",
        "fr": "annulé",
        "es": "cancelado",
        "de": "abgebrochen",
        "pt": "cancelado",
        "ar": "ألغيت",
        "ko": "취소 된"
      } +
      {
        "en": "No",
        "fr": "Non",
        "es": "No",
        "de": "Nein",
        "pt": "Não",
        "ar": "لا",
        "ko": "아니"
      } +
      {
        "en": "Yes",
        "fr": "Oui",
        "es": "sí",
        "de": "Ja",
        "pt": "sim",
        "ar": "نعم",
        "ko": "예"
      } +
      {
        "en": "Change Order Status",
        "fr": "Modifier le statut de la commande",
        "es": "Cambiar el estado de la orden",
        "de": "Bestellstatus ändern",
        "pt": "Alterar o status do pedido",
        "ar": "تغيير حالة الطلب",
        "ko": "주문 상태 변경"
      } +
      {
        "en": "Change",
        "fr": "Changer",
        "es": "Cambio",
        "de": "Veränderung",
        "pt": "Mudar",
        "ar": "يتغيرون",
        "ko": "변화"
      } +
      {
        "en": "pending",
        "fr": "en attendant",
        "es": "pendiente",
        "de": "steht aus",
        "pt": "pendente",
        "ar": "ريثما",
        "ko": "보류 중"
      } +
      {
        "en": "preparing",
        "fr": "en train de préparer",
        "es": "preparando",
        "de": "vorbereiten",
        "pt": "preparando",
        "ar": "خطة",
        "ko": "준비"
      } +
      {
        "en": "ready",
        "fr": "prêt",
        "es": "Listo",
        "de": "bereit",
        "pt": "pronto",
        "ar": "جاهز",
        "ko": "준비된"
      } +
      {
        "en": "enroute",
        "fr": "en route",
        "es": "en camino",
        "de": "unterwegs",
        "pt": "a caminho",
        "ar": "في المسار",
        "ko": "도중에"
      } +
      {
        "en": "failed",
        "fr": "manqué",
        "es": "ha fallado",
        "de": "gescheitert",
        "pt": "fracassado",
        "ar": "باءت بالفشل",
        "ko": "실패한"
      } +
      {
        "en": "delivered",
        "fr": "livré",
        "es": "entregado",
        "de": "geliefert",
        "pt": "entregue",
        "ar": "تم التوصيل",
        "ko": "배달"
      } +
      {
        "en": "successful",
        "fr": "à succès",
        "es": "exitoso",
        "de": "erfolgreich",
        "pt": "bem sucedido",
        "ar": "ناجح",
        "ko": "성공한"
      } +
      {
        "en": "Assign Order",
        "fr": "Attribuer une commande",
        "es": "Asignar orden",
        "de": "Auftrag zuweisen",
        "pt": "Atribuir pedido",
        "ar": "تعيين أمر",
        "ko": "주문 할당"
      } +
      {
        "en": "Assign Order To:",
        "fr": "Attribuer la commande à:",
        "es": "Asignar orden a:",
        "de": "Auftrag zuweisen an:",
        "pt": "Atribuir pedido a:",
        "ar": "تعيين الطلب إلى:",
        "ko": "주문 지정 :"
      } +
      {
        "en": "Online",
        "fr": "En ligne",
        "es": "En línea",
        "de": "Online",
        "pt": "Conectados",
        "ar": "متصل",
        "ko": "온라인"
      } +
      {
        "en": "Offline",
        "fr": "Hors ligne",
        "es": "Desconectado",
        "de": "Offline",
        "pt": "desligada",
        "ar": "غير متصل على الانترنت",
        "ko": "오프라인"
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
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
