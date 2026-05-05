import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("📩 إشعار في الخلفية: ${message.notification?.title}");
}

class FcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initFCM() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    debugPrint("📱 حالة الإذن: ${settings.authorizationStatus}");

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint(" المستخدم وافق على الإشعارات");

      await _initLocalNotifications();

      String? token = await getToken();
      debugPrint(" FCM Token: $token");

      await subscribeToTopic("all_users");

      _setupForegroundListener();

      _setupNotificationTapHandler();
    } else {
      debugPrint("المستخدم رفض الإشعارات");
    }
  }

  static Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint("تم الضغط على الإشعار المحلي: ${response.payload}");
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description: 'هذه القناة للإشعارات المهمة.', // description
      importance: Importance.max,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<String?> getToken() async {
    try {
      String? token = await _messaging.getToken();
      return token;
    } catch (e) {
      debugPrint("❌ خطأ في جلب التوكن: $e");
      return null;
    }
  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      debugPrint(" تم الاشتراك في topic: $topic");
    } catch (e) {
      debugPrint(" خطأ في الاشتراك: $e");
    }
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      debugPrint(" تم إلغاء الاشتراك من topic: $topic");
    } catch (e) {
      debugPrint(" خطأ في إلغاء الاشتراك: $e");
    }
  }

  static void _setupForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📩 إشعار جديد (Foreground):");
      debugPrint("   العنوان: ${message.notification?.title}");
      debugPrint("   المحتوى: ${message.notification?.body}");

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // عرض إشعار محلي
      if (notification != null && android != null) {
        _localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription: 'هذه القناة للإشعارات المهمة.',
              icon: '@mipmap/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          payload: message.data['click_action'],
        );
      }
    });
  }

  static void _setupNotificationTapHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(" المستخدم ضغط على الإشعار:");
      debugPrint("   العنوان: ${message.notification?.title}");
    });
  }
}
