import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "My Orders",
        "fr": "Mes commandes",
        "es": "Mis ordenes",
        "de": "meine Bestellungen",
        "pt": "minhas ordens",
        "ar": "طلباتي",
        "ko": "내 주문"
      } +
      {
        "en": "%s Product(s)",
        "fr": "Produit (s) %s",
        "es": "%s producto (s)",
        "de": "%s Produkt (e)",
        "pt": "%s produto (s)",
        "ar": "%s منتج (منتجات)",
        "ko": "%s 제품"
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
        "en": "No Order",
        "fr": "Pas de commande",
        "es": "Sin orden",
        "de": "Keine Bestellung",
        "pt": "Nenhuma ordem",
        "ar": "لا طلب",
        "ko": "주문 없음"
      } +
      {
        "en": "When you place an order, they will appear here",
        "fr": "Lorsque vous passez une commande, ils apparaîtront ici",
        "es": "Cuando hagas un pedido, aparecerán aquí.",
        "de": "Wenn Sie eine Bestellung aufgeben, werden diese hier angezeigt",
        "pt": "Quando você fizer um pedido, eles aparecerão aqui",
        "ar": "عند تقديم طلب ، سيظهرون هنا",
        "ko": "주문하면 여기에 표시됩니다."
      } +
      {
        "en": "scheduled",
        "fr": "programmé",
        "es": "programado",
        "de": "geplant",
        "pt": "agendado",
        "ar": "المقرر",
        "ko": "예정"
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
        "en": "cancelled",
        "fr": "annulé",
        "es": "cancelado",
        "de": "abgesagt",
        "pt": "cancelado",
        "ar": "ألغيت",
        "ko": "취소 된"
      }+{
        "en": "scheduled",
        "fr": "programmé",
        "es": "programado",
        "de": "geplant",
        "pt": "agendado",
        "ar": "المقرر",
        "ko": "예정"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
