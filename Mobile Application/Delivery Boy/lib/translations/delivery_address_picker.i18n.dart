import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
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
        "en": "Select order delivery address",
        "fr": "Sélectionnez l'adresse de livraison de la commande",
        "es": "Seleccione la dirección de entrega del pedido",
        "de": "Wählen Sie die Lieferadresse der Bestellung",
        "pt": "Selecione o endereço de entrega do pedido",
        "ar": "حدد عنوان تسليم الطلب",
        "ko": "주문 배송 주소 선택"
      } +
      {
        "en": "New",
        "fr": "Nouveau",
        "es": "Nuevo",
        "de": "Neu",
        "pt": "Novo",
        "ar": "جديد",
        "ko": "새로운"
      } +
      {
        "en": "Choose on map",
        "fr": "Choisissez sur la carte",
        "es": "Elija en el mapa",
        "de": "Wählen Sie auf der Karte",
        "pt": "Escolha no mapa",
        "ar": "اختر على الخريطة",
        "ko": "지도에서 선택"
      } +
      {
        "en": "Location Permission Request",
        "fr": "Demande d'autorisation d'emplacement",
        "es": "Solicitud de permiso de ubicación",
        "de": "Standortgenehmigungsanforderung",
        "pt": "Pedido de permissão de localização",
        "ar": "طلب إذن الموقع",
        "ko": "위치 권한 요청"
      } +
      {
        "en":
            "requires your location permission to enable customer track your location when delivering their order",
        "fr":
            "nécessite votre autorisation de localisation pour permettre au client de suivre votre position lors de la livraison de sa commande",
        "es":
            "requiere su permiso de ubicación para permitir que el cliente rastree su ubicación cuando entregue su pedido",
        "de":
            "erfordert Ihre Standortberechtigung, damit der Kunde Ihren Standort bei der Lieferung seiner Bestellung verfolgen kann",
        "pt":
            "requer sua permissão de localização para permitir que o cliente rastreie sua localização ao entregar o pedido",
        "ar": "يتطلب إذن موقعك لتمكين العميل من تتبع موقعك عند تسليم طلبهم",
        "ko": "고객이 주문을 배송 할 때 위치를 추적 할 수 있도록 위치 권한이 필요합니다."
      } +
      {
        "en": "Request Permission",
        "fr": "Demander la permission",
        "es": "Solicitar permiso",
        "de": "Um Erlaubnis bitten",
        "pt": "Solicitar permissão",
        "ar": "طلب إذن",
        "ko": "권한 요청"
      } +
      {
        "en": "Cancel",
        "fr": "Annuler",
        "es": "Cancelar",
        "de": "Stornieren",
        "pt": "Cancelar",
        "ar": "يلغي",
        "ko": "취소"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
