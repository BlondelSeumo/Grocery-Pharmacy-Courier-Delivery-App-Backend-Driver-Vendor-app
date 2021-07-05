import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Past Orders",
        "fr": "Commandes passées",
        "es": "Pedidos anteriores",
        "de": "Frühere Bestellungen",
        "pt": "Pedidos anteriores",
        "ar": "الطلبات السابقة",
        "ko": "과거 주문"
      } +
      {
        "en": "Assigned Orders",
        "fr": "Ordres attribués",
        "es": "Órdenes asignadas",
        "de": "Zugeordnete Bestellungen",
        "pt": "Pedidos Atribuídos",
        "ar": "الأوامر المعينة",
        "ko": "지정된 주문"
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
        "en": "When you are assigned an order, they will appear here",
        "fr": "Lorsque vous recevez une commande, elle apparaîtra ici",
        "es": "Cuando se le asigne un pedido, aparecerán aquí",
        "de": "Wenn Sie eine Bestellung erhalten, werden diese hier angezeigt",
        "pt": "Quando você receber um pedido, eles aparecerão aqui",
        "ar": "عندما يتم تعيين طلب لك ، سيظهرون هنا",
        "ko": "주문이 할당되면 여기에 표시됩니다."
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
