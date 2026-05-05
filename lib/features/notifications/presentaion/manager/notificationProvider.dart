import 'package:flutter/foundation.dart';
import 'package:lumiere/features/notifications/data/models/notification.dart';
import 'package:lumiere/features/notifications/data/repo/notificationRepo.dart';

class Notificationprovider extends ChangeNotifier {
  final NotificationRepo _notificationRepo = NotificationRepo();
  bool isLoading = false;

  Future<void> nottifyallusers({
    required String title,
    required String body,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      await _notificationRepo.SendToAllUsers(title: title, body: body);
      print("تم ارسال الاشعار لجميع المستخدمين بنجاح");
    } catch (e) {
      print("فشل ارسال الاشعار: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> notifyAdmin({
    required String title,
    required String body,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      String? adminToken = await _notificationRepo.getAdminToken();
      if (adminToken != null) {
        final notification = Notification(
          title: title,
          body: body,
          receiverId: adminToken,
        );
        await _notificationRepo.sendDirectNotificationt(notification);
      }
    } catch (e) {
      print("فشل ارسال الاشعار للإدارة: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
