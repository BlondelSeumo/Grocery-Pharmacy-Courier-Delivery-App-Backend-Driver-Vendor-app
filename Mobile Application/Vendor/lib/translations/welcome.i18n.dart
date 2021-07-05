import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Welcome",
        "fr": "Bienvenue",
        "es": "Bienvenida",
        "de": "Herzlich willkommen",
        "pt": "Receber",
        "ar": "أهلا بك",
        "ko": "어서 오십시오"
      } +
      {
        "en": "How can I help you today?",
        "fr": "Comment puis-je vous aider aujourd'hui?",
        "es": "¿Cómo puedo ayudarte hoy?",
        "de": "Wie kann ich Ihnen heute helfen?",
        "pt": "Como posso te ajudar hoje?",
        "ar": "كيف استطيع مساعدتك اليوم؟",
        "ko": "오늘 무엇을 도와 드릴까요?"
      } +
      {
        "en": "I want to:",
        "fr": "Je veux:",
        "es": "Quiero:",
        "de": "Ich möchte:",
        "pt": "Eu quero:",
        "ar": "أريد أن:",
        "ko": "나는 원한다 :"
      } +
      {
        "en": "Send packages",
        "fr": "Envoyer des colis",
        "es": "Enviar paquetes",
        "de": "Pakete senden",
        "pt": "Enviar pacotes",
        "ar": "إرسال الحزم",
        "ko": "패키지 보내기"
      } +
      {
        "en": "Send packages to anyone, anywhere at anytime",
        "fr":
            "Envoyez des colis à n'importe qui, n'importe où et n'importe quand",
        "es":
            "Envíe paquetes a cualquier persona, en cualquier lugar y en cualquier momento",
        "de": "Senden Sie Pakete an jeden, überall und jederzeit",
        "pt":
            "Envie pacotes para qualquer pessoa, em qualquer lugar e a qualquer hora",
        "ar": "إرسال حزم إلى أي شخص ، في أي مكان وفي أي وقت",
        "ko": "언제 어디서나 누구에게나 패키지 보내기"
      } +
      {
        "en": "Get Food/Grocery Delivery",
        "fr": "Livraison de nourriture / épicerie",
        "es": "Obtener comida / entrega de comestibles",
        "de": "Holen Sie sich Lebensmittel / Lebensmittel Lieferung",
        "pt": "Obter entrega de alimentos / mantimentos",
        "ar": "احصل على توصيل الطعام / البقالة",
        "ko": "음식 / 식료품 배달 받기"
      } +
      {
        "en": "Order for food, grocery and more from nearby vendors",
        "fr":
            "Commandez de la nourriture, de l'épicerie et plus encore auprès des vendeurs à proximité",
        "es": "Ordene alimentos, comestibles y más a proveedores cercanos",
        "de":
            "Bestellen Sie Lebensmittel, Lebensmittel und mehr bei nahe gelegenen Anbietern",
        "pt":
            "Pedidos de comida, mercearia e muito mais de fornecedores próximos",
        "ar": "اطلب الطعام والبقالة والمزيد من البائعين القريبين",
        "ko": "근처 판매점에서 음식, 식료품 등을 주문하십시오."
      } +
      {
        "en": "Market",
        "fr": "Marché",
        "es": "Mercado",
        "de": "Markt",
        "pt": "Mercado",
        "ar": "سوق",
        "ko": "시장"
      } +
      {
        "en": "Send Package",
        "fr": "Envoyer le colis",
        "es": "Enviar paquete",
        "de": "Paket senden",
        "pt": "Enviar Pacote",
        "ar": "إرسال الحزمة",
        "ko": "패키지 보내기"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
