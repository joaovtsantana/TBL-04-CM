
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/notification_model.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>();

class NotificationProvider extends ChangeNotifier {

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  final List<NotificationModel> notifications = [];

  Future<void> initialize() async {

    const settings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
      iOS: DarwinInitializationSettings(),
    );

    await plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {

        final route = response.payload;

        if (route != null) {
          navigatorKey.currentState?.pushNamed(route);
        }
      },
    );

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    final launchDetails =
        await plugin.getNotificationAppLaunchDetails();

    if (launchDetails?.didNotificationLaunchApp ?? false) {

      final route =
          launchDetails?.notificationResponse?.payload;

      if (route != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigatorKey.currentState?.pushNamed(route);
        });
      }
    }
  }

  Future<void> sendFakeNotification() async {

    final notification = NotificationModel(
      title: 'Nova mensagem',
      body: 'Você recebeu uma nova mensagem!',
      route: '/chat',
    );

    notifications.insert(0, notification);

    const details = NotificationDetails(
    android: AndroidNotificationDetails(
      'messages_channel',
      'Mensagens',
      channelDescription: 'Notificações de mensagens',
      importance: Importance.max,
      priority: Priority.high,
    ),
      iOS: DarwinNotificationDetails(),
    );

    await plugin.show(
      id: 1,
      title: notification.title,
      body: notification.body,
      notificationDetails: details,
      payload: notification.route,
    );

    notifyListeners();
  }
}
