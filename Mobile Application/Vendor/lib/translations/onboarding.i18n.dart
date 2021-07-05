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
        "en": "Take Orders",
        "fr": "Prendre des ordres",
        "es": "Tomar órdenes",
        "de": "Bestellungen aufnehmen",
        "pt": "Aceitar pedidos",
        "ar": "خذ الطلبات",
        "ko": "주문을 받다"
      } +
      {
        "en": "Get notified as soon as an order is place",
        "fr": "Soyez averti dès qu'une commande est passée",
        "es": "Reciba una notificación tan pronto como se realice un pedido",
        "de":
            "Lassen Sie sich benachrichtigen, sobald eine Bestellung eingegangen ist",
        "pt": "Seja notificado assim que um pedido for feito",
        "ar": "احصل على إخطار بمجرد تقديم الطلب",
        "ko": "주문이 접수되는 즉시 알림 받기"
      } +
      {
        "en": "Chat with driver/customer",
        "fr": "Discuter avec le chauffeur / client",
        "es": "Chatear con conductor / cliente",
        "de": "Chatten Sie mit dem Fahrer / Kunden",
        "pt": "Converse com motorista / cliente",
        "ar": "الدردشة مع السائق / العميل",
        "ko": "운전 기사 / 고객과 채팅"
      } +
      {
        "en":
            "Call/Chat with driver/delivery boy for update about your order and more",
        "fr":
            "Appelez / discutez avec le chauffeur / livreur pour une mise à jour de votre commande et plus",
        "es":
            "Llame / Chatee con el conductor / repartidor para recibir actualizaciones sobre su pedido y más",
        "de":
            "Rufen Sie an / chatten Sie mit dem Fahrer / Lieferjungen, um Informationen zu Ihrer Bestellung und mehr zu erhalten",
        "pt":
            "Ligue / converse com o motorista / entregador para atualizações sobre o seu pedido e muito mais",
        "ar": "اتصل / تحدث مع السائق / خادم التوصيل لتحديث طلبك والمزيد",
        "ko": "주문 등에 대한 업데이트를 위해 운전 기사 / 배달원과 전화 / 채팅"
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
        "en": "See your earning increase with demand",
        "fr": "Voyez vos revenus augmenter avec la demande",
        "es": "Vea cómo aumentan sus ganancias con la demanda",
        "de": "Sehen Sie, wie Ihr Einkommen mit der Nachfrage steigt",
        "pt": "Veja o aumento de seus ganhos com a demanda",
        "ar": "شاهد زيادة أرباحك مع الطلب",
        "ko": "수요에 따른 수입 증가 확인"
      };

  String get i18n => localize(this, _t);
}
