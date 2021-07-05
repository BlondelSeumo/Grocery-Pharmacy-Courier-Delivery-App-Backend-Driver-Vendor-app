import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Skip",
        "fr": "Sauter",
        "es": "Saltar",
        "de": "Überspringen",
        "pt": "Pular",
        "ar": "تخطى",
        "ko": "건너 뛰기"
      } +
      {
        "en": "Next",
        "fr": "Suivant",
        "es": "Próximo",
        "de": "Nächster",
        "pt": "Próximo",
        "ar": "التالي",
        "ko": "다음"
      } +
      {
        "en": "Done",
        "fr": "Fait",
        "es": "Hecho",
        "de": "Getan",
        "pt": "Feito",
        "ar": "منتهي",
        "ko": "끝난"
      } +
      {
        "en": "Delivery made easy",
        "fr": "Livraison simplifiée",
        "es": "Entrega simplificada",
        "de": "Lieferung leicht gemacht",
        "pt": "Entrega facilitada",
        "ar": "أصبح التسليم سهلاً",
        "ko": "간편한 배송"
      } +
      {
        "en": "Get notified as soon as an order is available for delivery",
        "fr":
            "Soyez averti dès qu'une commande est disponible pour la livraison",
        "es":
            "Reciba una notificación tan pronto como un pedido esté disponible para su entrega",
        "de":
            "Lassen Sie sich benachrichtigen, sobald eine Bestellung zur Lieferung verfügbar ist",
        "pt":
            "Seja notificado assim que um pedido estiver disponível para entrega",
        "ar": "احصل على إشعار بمجرد توفر الطلب للتسليم",
        "ko": "주문을 배송 할 수있는 즉시 알림 받기"
      } +
      {
        "en": "Chat with vendor/customer",
        "fr": "Discuter avec le fournisseur / client",
        "es": "Chatear con proveedor / cliente",
        "de": "Chatten Sie mit dem Anbieter / Kunden",
        "pt": "Converse com fornecedor / cliente",
        "ar": "الدردشة مع البائع / العميل",
        "ko": "공급 업체 / 고객과 채팅"
      } +
      {
        "en":
            "Call/Chat with vendor/delivery boy for update about your order and more",
        "fr":
            "Appeler / discuter avec le vendeur / livreur pour une mise à jour sur votre commande et plus",
        "es":
            "Llame / Chatee con el proveedor / repartidor para recibir actualizaciones sobre su pedido y más",
        "de":
            "Rufen Sie an / chatten Sie mit dem Verkäufer / Lieferjungen, um Informationen zu Ihrer Bestellung und mehr zu erhalten",
        "pt":
            "Ligue / converse com o vendedor / entregador para atualizações sobre o seu pedido e muito mais",
        "ar": "اتصل / تحدث مع البائع / مندوب التوصيل لتحديث طلبك والمزيد",
        "ko": "주문 등에 대한 업데이트를 위해 공급 업체 / 배송 소년과 전화 / 채팅"
      } +
      {
        "en": "Earning",
        "fr": "Revenus",
        "es": "Ganador",
        "de": "Verdienen",
        "pt": "Ganho",
        "ar": "كسب",
        "ko": "적립"
      } +
      {
        "en": "You get commissions from every delivery made",
        "fr": "Vous recevez des commissions sur chaque livraison effectuée",
        "es": "Obtienes comisiones por cada entrega realizada",
        "de": "Sie erhalten Provisionen für jede Lieferung",
        "pt": "Você recebe comissões de cada entrega feita",
        "ar": "تحصل على عمولات من كل عملية تسليم",
        "ko": "모든 배송에서 수수료를받습니다."
      };

  String get i18n => localize(this, _t);
}
