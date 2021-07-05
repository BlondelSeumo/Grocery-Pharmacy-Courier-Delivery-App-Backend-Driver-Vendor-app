import 'dart:convert';

import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/notification.dart';

import 'local_storage.service.dart';

class NotificationService {
  //
  static Future<List<NotificationModel>> getNotifications() async {
    //
    final notificationsStringList = await LocalStorageService.prefs.getString(
      AppStrings.notificationsKey,
    );

    if (notificationsStringList == null) {
      return [];
    }

    return (jsonDecode(notificationsStringList) as List)
        .asMap()
        .entries
        .map((notificationObject) {
      //
      return NotificationModel(
        index: notificationObject.key,
        title: notificationObject.value["title"],
        body: notificationObject.value["body"],
        timeStamp: notificationObject.value["timeStamp"],
      );
    }).toList();
  }

  static void addNotification(NotificationModel notification) async {
    //
    final notifications = await getNotifications() ?? [];
    notifications.insert(0,notification);

    //
    await LocalStorageService.prefs.setString(
      AppStrings.notificationsKey,
      jsonEncode(notifications),
    );
  }

  static void updateNotification(NotificationModel notificationModel) async {
    //
    final notifications = await getNotifications();
    notifications.removeAt(notificationModel.index);
    notifications.insert(notificationModel.index, notificationModel);
    await LocalStorageService.prefs.setString(
      AppStrings.notificationsKey,
      jsonEncode(notifications),
    );
  }
}
