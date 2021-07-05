import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "No Notifications",
        "fr": "Aucune notification",
        "es": "No Notificaciones",
        "de": "Keine Benachrichtigungen",
        "pt": "Nenhuma notificação",
        "ar": "لا إشعارات",
        "ko": "알림 없음"
      } +
      {
        "en":
            "You dont' have notifications yet. When you get notifications, they will appear here",
        "fr":
            "Vous n'avez pas encore de notifications. Lorsque vous recevez des notifications, elles apparaîtront ici",
        "es":
            "Aún no tienes notificaciones. Cuando reciba notificaciones, aparecerán aquí.",
        "de":
            "Sie haben noch keine Benachrichtigungen. Wenn Sie Benachrichtigungen erhalten, werden diese hier angezeigt",
        "pt":
            "Você ainda não tem notificações. Quando você receber notificações, elas aparecerão aqui",
        "ar": "ليس لديك إخطارات حتى الآن. عندما تتلقى إشعارات ، ستظهر هنا",
        "ko": "아직 알림이 없습니다. 알림을 받으면 여기에 표시됩니다."
      } +
      {
        "en": "Notifications",
        "fr": "Notifications",
        "es": "Notificaciones",
        "de": "Benachrichtigungen",
        "pt": "Notificações",
        "ar": "إشعارات",
        "ko": "알림"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
