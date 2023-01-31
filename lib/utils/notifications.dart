import 'package:awesome_notifications/awesome_notifications.dart';

import 'app_utils.dart';

Future<void> createNotification({
  required String title,
  required String body,
  required NotificationCalendar schedule,
}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'CANCEL',
        label: 'Tắt thông báo',
        autoDismissible: true,
      ),
    ],
    schedule: schedule,
  );
}
