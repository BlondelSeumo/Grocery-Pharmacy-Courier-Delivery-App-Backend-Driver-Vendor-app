import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Search",
        "fr": "Chercher",
        "es": "Buscar",
        "de": "Suche",
        "pt": "Procurar",
        "ar": "بحث",
        "ko": "검색"
      } +
      {
        "en": "Ordered by Nearby first",
        "fr": "Commandé par À proximité en premier",
        "es": "Ordenado por Near primero",
        "de": "Zuerst in der Nähe bestellt",
        "pt": "Ordenado por Perto primeiro",
        "ar": "مرتبة حسب الجوار أولاً",
        "ko": "근처에서 먼저 주문"
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
        "en": "Vendors",
        "fr": "Vendeurs",
        "es": "Vendedores",
        "de": "Anbieter",
        "pt": "Vendedores",
        "ar": "الباعة",
        "ko": "공급 업체"
      };

  String get i18n => localize(this, _t);
}
