import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Browse through different vendors",
        "fr": "Parcourez différents fournisseurs",
        "es": "Navegar a través de diferentes proveedores",
        "de": "Durchsuchen Sie verschiedene Anbieter",
        "pt": "Navegue por diferentes fornecedores",
        "ar": "تصفح من خلال البائعين المختلفين",
        "ko": "다양한 공급 업체 찾아보기"
      } +
      {
        "en": "Get your favourite meal/food/items from varities of vendor",
        "fr":
            "Obtenez votre repas / nourriture / articles préférés de divers fournisseurs",
        "es":
            "Obtenga su comida / comida / artículos favoritos de una variedad de proveedores",
        "de":
            "Holen Sie sich Ihr Lieblingsessen / Essen / Artikel von verschiedenen Anbietern",
        "pt":
            "Obtenha sua refeição / comida / itens favoritos de vários fornecedores",
        "ar": "احصل على وجبتك / طعامك / أصنافك المفضلة من مختلف البائعين",
        "ko": "다양한 공급 업체에서 좋아하는 식사 / 음식 / 아이템을 가져옵니다."
      } +
      {
        "en": "Chat with vendor/delivery boy",
        "fr": "Discuter avec le vendeur / livreur",
        "es": "Chatear con el vendedor / repartidor",
        "de": "Chatten Sie mit dem Verkäufer / Lieferjungen",
        "pt": "Converse com o vendedor / entregador",
        "ar": "الدردشة مع البائع / فتى التوصيل",
        "ko": "공급 업체 / 배송 소년과 채팅"
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
        "en": "Delivery made easy",
        "fr": "Livraison simplifiée",
        "es": "Entrega simplificada",
        "de": "Lieferung leicht gemacht",
        "pt": "Entrega facilitada",
        "ar": "أصبح التسليم سهلاً",
        "ko": "간편한 배송"
      } +
      {
        "en":
            "Get your ordered food/item or parcel delivered at a very fast, cheap and reliable way",
        "fr":
            "Faites livrer votre nourriture / article ou colis commandé de manière très rapide, bon marché et fiable",
        "es":
            "Reciba la comida / artículo o paquete que solicitó de una manera muy rápida, económica y confiable",
        "de":
            "Lassen Sie sich Ihre bestellten Lebensmittel / Artikel oder Pakete sehr schnell, günstig und zuverlässig liefern",
        "pt":
            "Receba a entrega de seu alimento / item ou pacote de uma maneira muito rápida, barata e confiável",
        "ar":
            "احصل على الطعام / العنصر أو الطرد الذي طلبته بطريقة سريعة جدًا ورخيصة وموثوقة",
        "ko": "주문한 음식 / 품목 또는 소포를 매우 빠르고 저렴하며 신뢰할 수있는 방법으로 배달하십시오."
      };

  String get i18n => localize(this, _t);
}
