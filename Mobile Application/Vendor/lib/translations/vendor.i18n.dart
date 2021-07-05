import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Vendor Details",
        "fr": "Détails du fournisseur",
        "es": "Detalles del proveedor",
        "de": "Herstellerdetails",
        "pt": "Detalhes do vendedor",
        "ar": "تفاصيل البائع",
        "ko": "공급 업체 세부 정보"
      } +
      {
        "en": "Orders Report",
        "fr": "Rapport de commandes",
        "es": "Informe de pedidos",
        "de": "Auftragsbericht",
        "pt": "Relatório de pedidos",
        "ar": "تقرير الطلبات",
        "ko": "주문 보고서"
      } +
      {
        "en": "Weekly sales report",
        "fr": "Rapport de ventes hebdomadaire",
        "es": "Informe de ventas semanal",
        "de": "Wöchentlicher Verkaufsbericht",
        "pt": "Relatório semanal de vendas",
        "ar": "تقرير المبيعات الأسبوعي",
        "ko": "주간 판매 보고서"
      } +
      {
        "en": "Total Earnings \n(Currently)",
        "fr": "Gains totaux \n(actuellement)",
        "es": "Ingresos totales \n(actualmente)",
        "de": "Gesamteinkommen \n(Derzeit)",
        "pt": "Ganhos totais \n(atualmente)",
        "ar": "إجمالي الأرباح \n(حاليًا)",
        "ko": "총 수입 \n(현재)"
      } +
      {
        "en": "Monday",
        "fr": "lundi",
        "es": "lunes",
        "de": "Montag",
        "pt": "Segunda-feira",
        "ar": "الاثنين",
        "ko": "월요일"
      } +
      {
        "en": "Tuesday",
        "fr": "Mardi",
        "es": "martes",
        "de": "Dienstag",
        "pt": "terça",
        "ar": "يوم الثلاثاء",
        "ko": "화요일"
      } +
      {
        "en": "Wednesday",
        "fr": "Mercredi",
        "es": "miércoles",
        "de": "Mittwoch",
        "pt": "quarta-feira",
        "ar": "الأربعاء",
        "ko": "수요일"
      } +
      {
        "en": "Thursday",
        "fr": "jeudi",
        "es": "jueves",
        "de": "Donnerstag",
        "pt": "quinta-feira",
        "ar": "يوم الخميس",
        "ko": "목요일"
      } +
      {
        "en": "Friday",
        "fr": "Vendredi",
        "es": "viernes",
        "de": "Freitag",
        "pt": "sexta-feira",
        "ar": "جمعة",
        "ko": "금요일"
      } +
      {
        "en": "Saturday",
        "fr": "samedi",
        "es": "sábado",
        "de": "Samstag",
        "pt": "sábado",
        "ar": "السبت",
        "ko": "토요일"
      } +
      {
        "en": "Sunday",
        "fr": "dimanche",
        "es": "domingo",
        "de": "Sonntag",
        "pt": "Domigo",
        "ar": "الأحد",
        "ko": "일요일"
      } +
      {
        "en": "Mon",
        "fr": "Mon",
        "es": "Mi",
        "de": "Meine",
        "pt": "Minhas",
        "ar": "لي",
        "ko": "나의"
      } +
      {
        "en": "Tue",
        "fr": "Le vôtre",
        "es": "Tuya",
        "de": "Deine",
        "pt": "Seu",
        "ar": "خاصة بك",
        "ko": "당신 것"
      } +
      {
        "en": "Wed",
        "fr": "mer",
        "es": "casarse",
        "de": "Heiraten",
        "pt": "Casar",
        "ar": "الأربعاء",
        "ko": "수요일"
      } +
      {
        "en": "Thur",
        "fr": "Jeudi",
        "es": "Jueves",
        "de": "Thur",
        "pt": "Qui",
        "ar": "ثور",
        "ko": "목"
      } +
      {
        "en": "Fri",
        "fr": "ven",
        "es": "Vie",
        "de": "Fr.",
        "pt": "Sex",
        "ar": "الجمعة",
        "ko": "금"
      } +
      {
        "en": "Sat",
        "fr": "Sam",
        "es": "Se sentó",
        "de": "Sa.",
        "pt": "Sentado",
        "ar": "جلس",
        "ko": "수능"
      } +
      {
        "en": "Sun",
        "fr": "Soleil",
        "es": "sol",
        "de": "Sonne",
        "pt": "sol",
        "ar": "شمس",
        "ko": "태양"
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
        "es": "Habla a",
        "de": "Adresse",
        "pt": "Endereço",
        "ar": "عنوان",
        "ko": "주소"
      } +
      {
        "en": "Total Orders",
        "fr": "Total des commandes",
        "es": "Órdenes totales",
        "de": "Bestellungen insgesamt",
        "pt": "Pedidos totais",
        "ar": "إجمالي الطلبات",
        "ko": "총 주문"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
