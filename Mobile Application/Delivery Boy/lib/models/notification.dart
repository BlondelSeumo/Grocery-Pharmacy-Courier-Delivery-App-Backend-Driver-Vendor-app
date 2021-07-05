import 'package:intl/intl.dart';

class NotificationModel {
  int index;
  String title;
  String body;
  int timeStamp;
  bool read;

  NotificationModel({
    this.index,
    this.title,
    this.body,
    this.timeStamp,
    this.read = false,
  });

  String get formattedTimeStamp {
    final notificationDateTime =
        DateTime.fromMillisecondsSinceEpoch(this.timeStamp);
    final formmartedDate = DateFormat("EEE dd, MMM yyyy").format(
      notificationDateTime,
    );
    return "$formmartedDate";
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'timeStamp': timeStamp,
        'read': read,
      };
}
