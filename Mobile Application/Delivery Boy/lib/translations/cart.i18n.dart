import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "My Cart",
        "fr": "Mon panier",
        "es": "Mi carrito",
        "de": "Mein Warenkorb",
        "pt": "Meu carrinho",
        "ar": "عربة التسوق الخاصة بي",
        "ko": "내 카트"
      } +
      {
        "en": "Oopps!",
        "fr": "Oups!",
        "es": "¡Vaya!",
        "de": "Oopps!",
        "pt": "Oopps!",
        "ar": "عفوًا!",
        "ko": "웁스!"
      } +
      {
        "en": "Sorry, you have no product in your cart",
        "fr": "Désolé, vous n'avez aucun produit dans votre panier",
        "es": "Lo sentimos, no tienes ningún producto en tu carrito",
        "de": "Entschuldigung, Sie haben kein Produkt in Ihrem Warenkorb",
        "pt": "Desculpe, você não tem nenhum produto em seu carrinho",
        "ar": "عذرا ، ليس لديك أي منتج في سلة التسوق الخاصة بك",
        "ko": "죄송합니다. 장바구니에 제품이 없습니다."
      } +
      {
        "en": "Remove Product From Cart",
        "fr": "Retirer le produit du panier",
        "es": "Quitar producto del carrito",
        "de": "Produkt aus dem Warenkorb nehmen",
        "pt": "Remova o produto do carrinho",
        "ar": "إزالة المنتج من عربة التسوق",
        "ko": "카트에서 제품 제거"
      } +
      {
        "en": "Are you sure you want to remove this product from cart?",
        "fr": "Êtes-vous sûr de vouloir supprimer ce produit du panier?",
        "es": "¿Está seguro de que desea eliminar este producto del carrito?",
        "de":
            "Möchten Sie dieses Produkt wirklich aus dem Warenkorb entfernen?",
        "pt": "Tem certeza de que deseja remover este produto do carrinho?",
        "ar": "هل أنت متأكد أنك تريد إزالة هذا المنتج من سلة التسوق؟",
        "ko": "이 제품을 장바구니에서 제거 하시겠습니까?"
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
        "en": "Entry Voucher Code",
        "fr": "Code du bon d'entrée",
        "es": "Código del vale de entrada",
        "de": "Zugangsgutscheincode",
        "pt": "Código de voucher de entrada",
        "ar": "رمز قسيمة الدخول",
        "ko": "입장권 코드"
      } +
      {
        "en": "Add Coupon",
        "fr": "Ajouter un coupon",
        "es": "Agregar cupón",
        "de": "Gutschein hinzufügen",
        "pt": "Adicionar cupom",
        "ar": "أضف عرض",
        "ko": "쿠폰 추가"
      } +
      {
        "en": "Coupon Code",
        "fr": "Code de coupon",
        "es": "Código promocional",
        "de": "Gutscheincode",
        "pt": "Código do cupom",
        "ar": "رمز الكوبون",
        "ko": "쿠폰 코드"
      } +
      {
        "en": "Apply",
        "fr": "Appliquer",
        "es": "Aplicar",
        "de": "Anwenden",
        "pt": "Aplicar",
        "ar": "يتقدم",
        "ko": "대다"
      } +
      {
        "en": "Total Item",
        "fr": "Article total",
        "es": "Artículo total",
        "de": "Gesamtartikel",
        "pt": "Artigo Total",
        "ar": "إجمالي البند",
        "ko": "총 항목"
      } +
      {
        "en": "Sub-Total",
        "fr": "Total",
        "es": "Total parcial",
        "de": "Zwischensumme",
        "pt": "Subtotal",
        "ar": "المجموع الفرعي",
        "ko": "소계"
      } +
      {
        "en": "Discount",
        "fr": "Rabais",
        "es": "Descuento",
        "de": "Rabatt",
        "pt": "Desconto",
        "ar": "خصم",
        "ko": "할인"
      } +
      {
        "en": "Total",
        "fr": "Total",
        "es": "Total",
        "de": "Gesamt",
        "pt": "Total",
        "ar": "مجموع",
        "ko": "합계"
      } +
      {
        "en": "CHECKOUT",
        "fr": "VÉRIFIER",
        "es": "REVISA",
        "de": "ÜBERPRÜFEN",
        "pt": "CONFIRA",
        "ar": "الدفع",
        "ko": "점검"
      } +
      {
        "en": "Remove From Cart",
        "fr": "Retirer du panier",
        "es": "Quitar del carrito",
        "de": "Aus dem Warenkorb nehmen",
        "pt": "Remover do carrinho",
        "ar": "إزالة من عربة التسوق",
        "ko": "카트에서 제거"
      };

  String get i18n => localize(this, _t);
}
