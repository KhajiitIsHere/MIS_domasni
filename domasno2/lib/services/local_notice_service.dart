import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNoticeService {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static LocalNoticeService? localNoticeService;

  static LocalNoticeService getService() {
    if (localNoticeService == null){
      localNoticeService = LocalNoticeService();
      localNoticeService!.setup();
    }
    return localNoticeService!;
  }

  Future<void> setup() async {
    const androidSetting = AndroidInitializationSettings('@drawable/burger');
    const iosSetting = DarwinInitializationSettings();

    const initSettings =
    InitializationSettings(android: androidSetting, iOS: iosSetting);

    // #3
    await _localNotificationsPlugin.initialize(initSettings);
  }

  Future<void> showNotification(
      String title,
      String body) async {

    const androidDetail = AndroidNotificationDetails(
        'default', // channel Id
        'default' // channel Name
    );

    const iosDetail = DarwinNotificationDetails();

    const noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

    await _localNotificationsPlugin.show(0, title, body, noticeDetail);
  }
}
