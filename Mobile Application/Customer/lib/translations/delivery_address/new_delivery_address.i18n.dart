import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "New Delivery Address",
        "fr": "Nouvelle adresse de livraison",
        "es": "Nueva dirección de entrega",
        "de": "Neue Lieferadresse",
        "pt": "Novo endereço de entrega",
        "ar": "عنوان التسليم الجديد",
        "ko": "새 배달 주소"
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
        "en": "Default",
        "fr": "Défaut",
        "es": "Defecto",
        "de": "Standard",
        "pt": "Predefinição",
        "ar": "تقصير",
        "ko": "기본"
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
        "en": "Name",
        "fr": "Nom",
        "es": "Nombre",
        "de": "Name",
        "pt": "Nome",
        "ar": "اسم",
        "ko": "이름"
      } +
      {
        "en": "Address",
        "fr": "Adresse",
        "es": "Dirección",
        "de": "Adresse",
        "pt": "Endereço",
        "ar": "تبوك",
        "ko": "주소"
      } +
      {
        "en": "Save",
        "fr": "Sauvegarder",
        "es": "Salvar",
        "de": "speichern",
        "pt": "Salve ",
        "ar": "يحفظ",
        "ko": "저장"
      } +
      {
        "en": "Get What3words name from this link",
        "fr": "Obtenez le nom What3words à partir de ce lien",
        "es": "Obtenga el nombre What3words de este enlace",
        "de": "Holen Sie sich den Namen What3words über diesen Link",
        "pt": "Obtenha o nome What3words neste link",
        "ar": "احصل على اسم عنوان 3 كلمات من هذا الارتباط",
        "ko": "이 링크에서 What3words 이름 가져 오기"
      } +
      {
        "en": "Pick On Map",
        "fr": "Choisir sur la carte",
        "es": "Seleccionar en el mapa",
        "de": "Auf Karte auswählen",
        "pt": "Escolha no mapa",
        "ar": "اختر على الخريطة",
        "ko": "지도에서 선택"
      } +
      {
        "en": "Enter your address...",
        "fr": "Entrez votre adresse ...",
        "es": "Ingrese su dirección ...",
        "de": "Geben Sie Ihre Adresse ein ...",
        "pt": "Digite seu endereço ...",
        "ar": "أدخل عنوانك ...",
        "ko": "주소를 입력하세요 ..."
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
