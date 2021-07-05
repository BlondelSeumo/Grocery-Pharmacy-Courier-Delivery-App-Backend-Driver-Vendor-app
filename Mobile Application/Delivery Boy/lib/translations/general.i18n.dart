import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Retry",
        "fr": "Recommencez",
        "es": "Rever",
        "de": "Wiederholen",
        "pt": "Tentar novamente",
        "ar": "أعد المحاولة",
        "ko": "다시 해 보다"
      } +
      {
        "en": "An error occured",
        "fr": "Une erreur s'est produite",
        "es": "Ocurrió un error",
        "de": "Es ist ein Fehler aufgetreten",
        "pt": "Um erro ocorreu",
        "ar": "حدث خطأ",
        "ko": "오류가 발생했습니다"
      } +
      {
        "en":
            "There was an error while processing your request. Please try again",
        "fr":
            "Une erreur s'est produite lors du traitement de votre demande. Veuillez réessayer",
        "es": "Hubo un error al procesar su solicitud. Inténtalo de nuevo",
        "de":
            "Bei der Bearbeitung Ihrer Anfrage ist ein Fehler aufgetreten. Bitte versuche es erneut",
        "pt":
            "Ocorreu um erro ao processar sua solicitação. Por favor, tente novamente",
        "ar": "كان هناك خطأ أثناء معالجة طلبك. حاول مرة اخرى",
        "ko": "요청을 처리하는 중에 오류가 발생했습니다. 다시 시도하십시오"
      } +
      {
        "en": "Order Summary",
        "fr": "Récapitulatif de la commande",
        "es": "Resumen de la orden",
        "de": "Bestellübersicht",
        "pt": "resumo do pedido",
        "ar": "ملخص الطلب",
        "ko": "주문 요약"
      } +
      {
        "en": "Subtotal",
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
        "en": "Delivery Fee",
        "fr": "Frais de livraison",
        "es": "Gastos de envío",
        "de": "Liefergebühr",
        "pt": "Taxa de entrega",
        "ar": "رسوم التوصيل",
        "ko": "배달 수수료"
      } +
      {
        "en": "Tax (%s)",
        "fr": "Taxe (%s)",
        "es": "Impuesto (%s)",
        "de": "Steuer (%s)",
        "pt": "Imposto (%s)",
        "ar": "الضريبة (%s)",
        "ko": "세금 (%s)"
      } +
      {
        "en": "Total Amount",
        "fr": "Montant total",
        "es": "Cantidad total",
        "de": "Gesamtsumme",
        "pt": "Valor total",
        "ar": "المبلغ الإجمالي",
        "ko": "총액"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
