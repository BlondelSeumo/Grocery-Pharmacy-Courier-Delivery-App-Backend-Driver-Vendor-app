import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Checkout",
        "fr": "Vérifier",
        "es": "Revisa",
        "de": "Überprüfen",
        "pt": "Confira",
        "ar": "الدفع",
        "ko": "점검"
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
        "en": "Delivery address",
        "fr": "Adresse de livraison",
        "es": "Dirección de entrega",
        "de": "Lieferadresse",
        "pt": "Endereço de entrega",
        "ar": "عنوان التسليم",
        "ko": "배달 주소"
      } +
      {
        "en": "Delivery address is out of vendor delivery range",
        "fr":
            "L'adresse de livraison est en dehors de la plage de livraison du fournisseur",
        "es":
            "La dirección de entrega está fuera del rango de entrega del proveedor",
        "de":
            "Die Lieferadresse liegt außerhalb des Lieferbereichs des Anbieters",
        "pt":
            "O endereço de entrega está fora do intervalo de entrega do fornecedor",
        "ar": "عنوان التسليم خارج نطاق تسليم البائع",
        "ko": "배송 주소가 공급 업체 배송 범위를 벗어났습니다."
      } +
      {
        "en": "Please select delivery address/location",
        "fr": "Veuillez sélectionner l'adresse / le lieu de livraison",
        "es": "Seleccione la dirección / ubicación de entrega",
        "de": "Bitte wählen Sie Lieferadresse / Ort",
        "pt": "Selecione o endereço / local de entrega",
        "ar": "يرجى تحديد عنوان التسليم / الموقع",
        "ko": "배송지 주소 / 위치를 선택하세요"
      } +
      {
        "en": "Pickup Order",
        "fr": "Ordre de ramassage",
        "es": "Orden para recoger",
        "de": "Bestellung aufnehmen",
        "pt": "Pedido de Retirada",
        "ar": "طلب الاستلام",
        "ko": "픽업 순서"
      } +
      {
        "en": "Payment Methods",
        "fr": "méthodes de payement",
        "es": "Métodos de pago",
        "de": "Zahlungsarten",
        "pt": "Métodos de Pagamento",
        "ar": "طرق الدفع",
        "ko": "지불 방법"
      } +
      {
        "en": "Please select a payment method",
        "fr": "Veuillez choisir un moyen de paiement",
        "es": "Por favor seleccione un método de pago",
        "de": "Bitte Zahlungsart wählen",
        "pt": "Selecione um método de pagamento",
        "ar": "الرجاء اختيار طريقة الدفع",
        "ko": "결제 방법을 선택하세요"
      } +
      {
        "en": "Please indicate if you would come pickup order at the vendor",
        "fr": "Veuillez indiquer si vous viendriez enlèvement chez le vendeur",
        "es": "Indique si vendría a recoger el pedido al proveedor",
        "de":
            "Bitte geben Sie an, ob Sie eine Abholbestellung beim Verkäufer erhalten würden",
        "pt":
            "Indique se você gostaria de fazer a ordem de coleta no fornecedor",
        "ar": "يرجى توضيح ما إذا كنت ستأتي لطلب الاستلام من البائع",
        "ko": "공급 업체에서 픽업 주문을받을 것인지 표시하십시오."
      } +
      {
        "en": "PLACE ORDER",
        "fr": "PASSER LA COMMANDE",
        "es": "REALIZAR PEDIDO",
        "de": "BESTELLUNG AUFGEBEN",
        "pt": "FAÇA A ENCOMENDA",
        "ar": "مكان الامر",
        "ko": "주문하기"
      } +
      {
        "en": "Processing order. Please wait...",
        "fr": "Commande en traitement. S'il vous plaît, attendez...",
        "es": "Orden de procesamiento. Espere por favor...",
        "de": "Bearbeitungsauftrag. Warten Sie mal...",
        "pt": "Processando o Pedido. Por favor, espere...",
        "ar": "معالجة الطلب. انتظر من فضلك...",
        "ko": "주문 처리 중입니다. 잠시만 기다려주세요 ..."
      } +
      {
        "en": "Product",
        "fr": "Produit",
        "es": "Producto",
        "de": "Produkt",
        "pt": "produtos",
        "ar": "منتج",
        "ko": "생성물"
      } +
      {
        "en":
            "There seems to be products that can not be delivered in your cart",
        "fr":
            "Il semble y avoir des produits qui ne peuvent pas être livrés dans votre panier",
        "es":
            "Parece que hay productos que no se pueden entregar en su carrito.",
        "de":
            "Es scheint Produkte zu geben, die nicht in Ihren Warenkorb geliefert werden können",
        "pt":
            "Parece haver produtos que não podem ser entregues no seu carrinho",
        "ar": "يبدو أن هناك منتجات لا يمكن تسليمها في عربة التسوق الخاصة بك",
        "ko": "장바구니에 담을 수없는 상품이있는 것 같습니다"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
