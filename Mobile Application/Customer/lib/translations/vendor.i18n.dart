import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "No Vendor Found",
        "fr": "Aucun fournisseur trouvé",
        "es": "No se encontró ningún proveedor",
        "de": "Kein Anbieter gefunden",
        "pt": "Nenhum fornecedor encontrado",
        "ar": "لم يتم العثور على بائع",
        "ko": "공급 업체를 찾을 수 없습니다."
      } +
      {
        "en": "There seems to be no vendor around your selected location",
        "fr":
            "Il semble n'y avoir aucun fournisseur à proximité de l'emplacement sélectionné",
        "es": "Parece que no hay ningún proveedor en la ubicación seleccionada",
        "de":
            "An Ihrem ausgewählten Standort scheint es keinen Anbieter zu geben",
        "pt": "Parece não haver nenhum fornecedor próximo ao local selecionado",
        "ar": "يبدو أنه لا يوجد بائع حول موقعك المحدد",
        "ko": "선택한 위치 주변에 공급 업체가없는 것 같습니다."
      } +
      {
        "en": "No Product Found",
        "fr": "Aucun produit trouvé",
        "es": "No se ha encontrado ningún producto",
        "de": "Kein Produkt gefunden",
        "pt": "Nenhum produto encontrado",
        "ar": "لم يتم العثور على منتج",
        "ko": "제품을 찾을 수 없음"
      } +
      {
        "en": "There seems to be no product",
        "fr": "Il semble n'y avoir aucun produit",
        "es": "Parece que no hay producto",
        "de": "Es scheint kein Produkt zu geben",
        "pt": "Parece não haver nenhum produto",
        "ar": "يبدو أنه لا يوجد منتج",
        "ko": "상품이없는 것 같습니다"
      } +
      {
        "en": "No Product/Vendor Found",
        "fr": "Aucun produit / fournisseur trouvé",
        "es": "No se encontró ningún producto / proveedor",
        "de": "Kein Produkt / Anbieter gefunden",
        "pt": "Nenhum produto / fornecedor encontrado",
        "ar": "لم يتم العثور على منتج / بائع",
        "ko": "제품 / 공급 업체를 찾을 수 없음"
      } +
      {
        "en": "There seems to be no product/vendor",
        "fr": "Il ne semble y avoir aucun produit / fournisseur",
        "es": "Parece que no hay ningún producto / proveedor",
        "de": "Es scheint kein Produkt / Anbieter zu geben",
        "pt": "Parece não haver nenhum produto / fornecedor",
        "ar": "يبدو أنه لا يوجد منتج / بائع",
        "ko": "제품 / 공급 업체가없는 것 같습니다."
      };

  String get i18n => localize(this, _t);
}
