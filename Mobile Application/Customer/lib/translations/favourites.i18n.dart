import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Remove Product From Favourite",
        "fr": "Supprimer le produit des favoris",
        "es": "Quitar producto de favorito",
        "de": "Produkt aus Favorit entfernen",
        "pt": "Remover o produto dos favoritos",
        "ar": "إزالة المنتج من المفضلة",
        "ko": "즐겨 찾기에서 제품 제거"
      } +
      {
        "en":
            "Are you sure you want to remove this product from your favourite list?",
        "fr":
            "Voulez-vous vraiment supprimer ce produit de votre liste de favoris?",
        "es":
            "¿Está seguro de que desea eliminar este producto de su lista de favoritos?",
        "de":
            "Möchten Sie dieses Produkt wirklich von Ihrer Favoritenliste entfernen?",
        "pt":
            "Tem certeza de que deseja remover este produto de sua lista de favoritos?",
        "ar": "هل أنت متأكد أنك تريد إزالة هذا المنتج من قائمتك المفضلة؟",
        "ko": "이 제품을 즐겨 찾기 목록에서 제거 하시겠습니까?"
      } +
      {
        "en": "Remove",
        "fr": "Supprimer",
        "es": "Eliminar",
        "de": "Entfernen",
        "pt": "Retirar",
        "ar": "يزيل",
        "ko": "없애다"
      } +
      {
        "en": "Favourites",
        "fr": "Favoris",
        "es": "Favoritos",
        "de": "Favoriten",
        "pt": "Favoritos",
        "ar": "المفضلة",
        "ko": "즐겨 찾기"
      } +
      {
        "en": "Note: Tap & Hold to remove favourite",
        "fr": "Remarque: appuyez et maintenez pour supprimer le favori",
        "es": "Nota: Toque y mantenga presionado para eliminar el favorito",
        "de": "Hinweis: Tippen und halten Sie, um den Favoriten zu entfernen",
        "pt": "Nota: Toque e segure para remover o favorito",
        "ar": "ملاحظة: انقر مع الاستمرار لإزالة المفضلة",
        "ko": "참고 : 즐겨 찾기를 제거하려면 길게 탭하세요."
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
