import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "FROM",
        "fr": "DE",
        "es": "DESDE",
        "de": "VON",
        "pt": "A PARTIR DE",
        "ar": "من",
        "ko": "에서"
      } +
      {
        "en": "Pickup Location",
        "fr": "Lieu de ramassage",
        "es": "Lugar de recogida",
        "de": "Treffpunkt",
        "pt": "Local de coleta",
        "ar": "اختر موقعا",
        "ko": "짐을 싣는 곳"
      } +
      {
        "en": "TO",
        "fr": "À",
        "es": "A",
        "de": "ZU",
        "pt": "PARA",
        "ar": "إلى",
        "ko": "에"
      } +
      {
        "en": "Dropoff Location",
        "fr": "Point de chute",
        "es": "Punto de entrega",
        "de": "Rückgabestation",
        "pt": "Local de entrega",
        "ar": "موقع الإنزال",
        "ko": "반납 장소"
      } +
      {
        "en": "DATE",
        "fr": "DATE",
        "es": "FECHA",
        "de": "DATUM",
        "pt": "ENCONTRO",
        "ar": "تاريخ",
        "ko": "데이트"
      } +
      {
        "en": "TIME",
        "fr": "TEMPS",
        "es": "HORA",
        "de": "ZEIT",
        "pt": "TEMPO",
        "ar": "الوقت",
        "ko": "시각"
      } +
      {
        "en": "select",
        "fr": "sélectionner",
        "es": "Seleccione",
        "de": "wählen",
        "pt": "selecionar",
        "ar": "تحديد",
        "ko": "고르다"
      } +
      {
        "en": "Recipient Info",
        "fr": "Informations sur le destinataire",
        "es": "Información del destinatario",
        "de": "Empfängerinfo",
        "pt": "Informação do Destinatário",
        "ar": "معلومات المستلم",
        "ko": "수신자 정보"
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
        "en": "Name of recipient",
        "fr": "Nom du récipient",
        "es": "Nombre del destinatario",
        "de": "Name des Empfängers",
        "pt": "Nome do recipiente",
        "ar": "اسم المستلم",
        "ko": "받는 사람의 이름"
      } +
      {
        "en": "phone",
        "fr": "téléphone",
        "es": "teléfono",
        "de": "Telefon",
        "pt": "telefone",
        "ar": "هاتف",
        "ko": "전화"
      } +
      {
        "en": "Phone number of recipient",
        "fr": "Numéro de téléphone du destinataire",
        "es": "Número de teléfono del destinatario",
        "de": "Telefonnummer des Empfängers",
        "pt": "Número de telefone do destinatário",
        "ar": "رقم هاتف المستلم",
        "ko": "수신자 전화 번호"
      } +
      {
        "en": "Package Parameters",
        "fr": "Paramètres du package",
        "es": "Parámetros del paquete",
        "de": "Paketparameter",
        "pt": "Parâmetros de pacote",
        "ar": "معلمات الحزمة",
        "ko": "패키지 매개 변수"
      } +
      {
        "en": "Weight",
        "fr": "Poids",
        "es": "Peso",
        "de": "Gewicht",
        "pt": "Peso",
        "ar": "وزن",
        "ko": "무게"
      } +
      {
        "en": "Length",
        "fr": "Longueur",
        "es": "Largo",
        "de": "Länge",
        "pt": "Comprimento",
        "ar": "طول",
        "ko": "길이"
      } +
      {
        "en": "Height",
        "fr": "Hauteur",
        "es": "Altura",
        "de": "Höhe",
        "pt": "Altura",
        "ar": "ارتفاع",
        "ko": "신장"
      } +
      {
        "en": "Width",
        "fr": "Largeur",
        "es": "Ancho",
        "de": "Breite",
        "pt": "Largura",
        "ar": "عرض",
        "ko": "폭"
      } +
      {
        "en": "CREATE A REQUEST",
        "fr": "CRÉER UNE DEMANDE",
        "es": "CREAR UNA SOLICITUD",
        "de": "ERSTELLEN SIE EINE ANFRAGE",
        "pt": "CRIAR UM PEDIDO",
        "ar": "قم بإنشاء طلب",
        "ko": "요청 생성"
      } +
      {
        "en": "NEXT",
        "fr": "SUIVANT",
        "es": "PRÓXIMO",
        "de": "NÄCHSTER",
        "pt": "PRÓXIMO",
        "ar": "التالي",
        "ko": "다음"
      } +
      {
        "en": "Delivery Info",
        "fr": "Informations de livraison",
        "es": "Información de entrega",
        "de": "Lieferinformationen",
        "pt": "Informação de entrega",
        "ar": "معلومات التوصيل",
        "ko": "배송 정보"
      } +
      {
        "en": "Select Package Type",
        "fr": "Sélectionnez le type de colis",
        "es": "Seleccione el tipo de paquete",
        "de": "Wählen Sie den Pakettyp",
        "pt": "Selecione o tipo de pacote",
        "ar": "حدد نوع الحزمة",
        "ko": "패키지 유형 선택"
      } +
      {
        "en": "PREVIOUS",
        "fr": "PRÉCÉDENT",
        "es": "ANTERIOR",
        "de": "BISHERIGE",
        "pt": "ANTERIOR",
        "ar": "السابق",
        "ko": "이전"
      } +
      {
        "en": "Select Courier Vendor",
        "fr": "Sélectionnez le fournisseur de messagerie",
        "es": "Seleccionar proveedor de mensajería",
        "de": "Wählen Sie Kurieranbieter",
        "pt": "Selecione o fornecedor de correio",
        "ar": "البائعين بريد اختيار",
        "ko": "택배 업체 선택"
      } +
      {
        "en": "Courier Vendor",
        "fr": "Fournisseur de courrier",
        "es": "Proveedor de mensajería",
        "de": "Kurierverkäufer",
        "pt": "Vendedor de correio",
        "ar": "بائع البريد السريع",
        "ko": "택배 업체"
      } +
      {
        "en": "Enter package weight",
        "fr": "Entrez le poids du colis",
        "es": "Ingrese el peso del paquete",
        "de": "Paketgewicht eingeben",
        "pt": "Insira o peso do pacote",
        "ar": "أدخل وزن الحزمة",
        "ko": "패키지 무게 입력"
      } +
      {
        "en": "Enter package length",
        "fr": "Entrez la longueur du colis",
        "es": "Ingrese la longitud del paquete",
        "de": "Paketlänge eingeben",
        "pt": "Insira o comprimento do pacote",
        "ar": "أدخل طول الحزمة",
        "ko": "패키지 길이 입력"
      } +
      {
        "en": "Enter package width",
        "fr": "Entrez la largeur du colis",
        "es": "Ingrese el ancho del paquete",
        "de": "Geben Sie die Paketbreite ein",
        "pt": "Insira a largura do pacote",
        "ar": "أدخل عرض الحزمة",
        "ko": "패키지 너비 입력"
      } +
      {
        "en": "Enter package height",
        "fr": "Entrez la hauteur du colis",
        "es": "Ingrese la altura del paquete",
        "de": "Pakethöhe eingeben",
        "pt": "Insira a altura do pacote",
        "ar": "أدخل ارتفاع الحزمة",
        "ko": "패키지 높이 입력"
      } +
      {
        "en": "Summary",
        "fr": "Résumé",
        "es": "Resumen",
        "de": "Zusammenfassung",
        "pt": "Resumo",
        "ar": "ملخص",
        "ko": "요약"
      } +
      {
        "en": "Payment",
        "fr": "Paiement",
        "es": "Pago",
        "de": "Zahlung",
        "pt": "Pagamento",
        "ar": "دفع",
        "ko": "지불"
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
        "en": "Distance",
        "fr": "Distance",
        "es": "Distancia",
        "de": "Entfernung",
        "pt": "Distância",
        "ar": "مسافه: بعد",
        "ko": "거리"
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
        "en": "Tax",
        "fr": "Impôt",
        "es": "Impuesto",
        "de": "MwSt",
        "pt": "Imposto",
        "ar": "ضريبة",
        "ko": "세"
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
        "en": "Delivery Charges",
        "fr": "Frais de livraison",
        "es": "Los gastos de envío",
        "de": "Versandkosten",
        "pt": "Taxas de entrega",
        "ar": "رسوم التوصيل",
        "ko": "배송료"
      } +
      {
        "en": "Please select your mode of payment",
        "fr": "Veuillez sélectionner votre mode de paiement",
        "es": "Seleccione su forma de pago",
        "de": "Bitte wählen Sie Ihre Zahlungsart",
        "pt": "Selecione o seu modo de pagamento",
        "ar": "الرجاء تحديد طريقة الدفع الخاصة بك",
        "ko": "지불 방법을 선택하십시오"
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
        "en": "Further instruction",
        "fr": "Instruction supplémentaire",
        "es": "Instrucción adicional",
        "de": "Weitere Instruktionen",
        "pt": "Mais instruções",
        "ar": "مزيد من التعليمات",
        "ko": "추가 지침"
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
        "en": "Package Size Charges",
        "fr": "Frais de taille de colis",
        "es": "Cargos por tamaño de paquete",
        "de": "Gebühren für die Paketgröße",
        "pt": "Encargos de tamanho de pacote",
        "ar": "رسوم حجم العبوة",
        "ko": "패키지 크기 요금"
      } +
      {
        "en": "Where to ...",
        "fr": "Où aller ...",
        "es": "A donde ...",
        "de": "Wohin ...",
        "pt": "Para onde ...",
        "ar": "إلى أين ...",
        "ko": "어디로 ..."
      } +
      {
        "en": "Add Stop",
        "fr": "Ajouter un arrêt",
        "es": "Agregar parada",
        "de": "Stop hinzufügen",
        "pt": "Adicionar parada",
        "ar": "أضف محطة",
        "ko": "경유지 추가"
      } +
      {
        "en": "Schedule Order",
        "fr": "Planifier la commande",
        "es": "Orden de programación",
        "de": "Bestellung planen",
        "pt": "Ordem de agendamento",
        "ar": "ترتيب الجدول",
        "ko": "주문 예약"
      } +
      {
        "en":
            "If you want your order to be delivered/prepared at scheduled date/time",
        "fr":
            "Si vous souhaitez que votre commande soit livrée / préparée à la date / heure prévue",
        "es":
            "Si desea que su pedido sea entregado / preparado en la fecha / hora programadas",
        "de":
            "Wenn Sie möchten, dass Ihre Bestellung zum geplanten Datum / zur geplanten Uhrzeit geliefert / vorbereitet wird",
        "pt":
            "Se você deseja que seu pedido seja entregue / preparado na data / hora programada",
        "ar": "إذا كنت ترغب في تسليم / تحضير طلبك في التاريخ / الوقت المحدد",
        "ko": "주문하신 날짜 / 시간에 배송 / 준비를 원하시는 경우"
      } +
      {
        "en": "Date slot",
        "fr": "Plage de date",
        "es": "Ranura de fecha",
        "de": "Datum Slot",
        "pt": "Slot de data",
        "ar": "خانة التاريخ",
        "ko": "날짜 슬롯"
      } +
      {
        "en": "Time slot",
        "fr": "Créneau horaire",
        "es": "Franja horaria",
        "de": "Zeitfenster",
        "pt": "Intervalo de tempo",
        "ar": "فسحة زمنية",
        "ko": "시간 슬롯"
      } +
      {
        "en": "ASAP",
        "fr": "FUMÉE",
        "es": "HUMO",
        "de": "RAUCH",
        "pt": "FUMAÇA",
        "ar": "دخان",
        "ko": "연기"
      } +
      {
        "en": "Stop",
        "fr": "Arrêter",
        "es": "Detener",
        "de": "Halt",
        "pt": "Pare",
        "ar": "قف",
        "ko": "중지"
      } +
      {
        "en": "DATE & TIME",
        "fr": "DATE & HEURE",
        "es": "FECHA Y HORA",
        "de": "TERMINZEIT",
        "pt": "DATA HORA",
        "ar": "التاريخ والوقت",
        "ko": "날짜 시간"
      } +
      {
        "en":
            "Vendor does not allow order scheduling. So you order will be processed as soon as you place them",
        "fr":
            "Le fournisseur n'autorise pas la planification des commandes. Ainsi, votre commande sera traitée dès que vous les passez",
        "es":
            "El proveedor no permite la programación de pedidos. Por lo tanto, su pedido será procesado tan pronto como los realice.",
        "de":
            "Der Lieferant erlaubt keine Auftragsplanung. Ihre Bestellung wird also bearbeitet, sobald Sie sie aufgeben",
        "pt":
            "O fornecedor não permite a programação de pedidos. Portanto, seu pedido será processado assim que você colocá-los",
        "ar":
            "لا يسمح البائع بجدولة الطلبات. لذلك ستتم معالجة طلبك بمجرد تقديمه",
        "ko": "공급 업체는 주문 예약을 허용하지 않습니다. 그래서 당신이 그들을 배치하자마자 주문이 처리됩니다"
      } +
      {
        "en": "Stop Location",
        "fr": "Emplacement de l'arrêt",
        "es": "Ubicación de parada",
        "de": "Standort stoppen",
        "pt": "Localização de parada",
        "ar": "وقف الموقع",
        "ko": "정류장 위치"
      } +
      {
        "en": "Vendor does not service selected location",
        "fr": "Le fournisseur ne dessert pas l'emplacement sélectionné",
        "es": "El proveedor no da servicio a la ubicación seleccionada",
        "de": "Der Anbieter bedient den ausgewählten Standort nicht",
        "pt": "O fornecedor não atende o local selecionado",
        "ar": "البائع لا يخدم الموقع المحدد",
        "ko": "공급 업체는 선택한 위치에 서비스를 제공하지 않습니다."
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
