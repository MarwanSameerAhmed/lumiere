import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:lumiere/features/notifications/data/models/notification.dart';

class NotificationRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String projectId = "lumere-app-fc2e2";

  static final _ServiceAccountCredentials = ServiceAccountCredentials.fromJson({
    "type": "service_account",
    "project_id": "lumere-app-fc2e2",
    "private_key_id": "76c551f0abbd3e3ee3d723a497e22fbb3ae0b4f8",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCn2aX6XhzGTr4Q\n1q8jyznjdfbNrqrCWUJpZcrEDZ+xy9g4bLd++XyWfYWA4gvBGvJ2z11Mhx0So4Qc\nf0WmR4Xhnr9libwX7ycks5AgXp1vNsgG8DVE9FUGPx2A6gKdIifHLpNR3L/Gs0Pk\nPMwmCU8VKudPb+YvR3cz1Tq5dPTtNAHr8fzUaegJuQq9J6Fb1j5KbBadeMZoNMjD\ny+qaKItNSyHxhyRwpOmOsvCTIMlhkEM9R+QwUg//NS/ju2yqdI5Gi5T9Xmb9Jmnh\naGQ+eW0OD0vNaEsCKdn1sj+FhiEJk3SaujR0fl6JS4P+BWjJv71MpLgY9VwBdc2a\nEGMeASHvAgMBAAECggEABXgKome37vYt1y/yMOu0N9G7eDl9XYEPBY7IK9nNyZCS\nEPSUiKc/BKA+Xf6qJ2E7Y9z0de6JEfcQnOUWCImYC8viVz/vnaVbKc+ineC3Ucz/\nzh9m0kJWat0E7GheLBnVdfXx3YmgbgGf8AB9yQIl+NNBtM2OkHJ2/dIFbHl/vs1q\nH61fOqVLyWb6Fhu5UWxPAvscBHPUW4/wVAfqMkGQwnBqfPoq6js5jBmDoBa+Hwl3\ntBrbhDZvLVab3X69336AhCglBYkOcCEgZIBpPHtKowr/k4hcgavUdsPXNSbZobdK\nGuMu5c0Zbu4PpQ5Ggvq2EL2pKYtxEntZ6RR8P6GHQQKBgQDeqBU7WNklDyaYdUlQ\nUkz1wrS3PuD5zT+8yjBLSKMmtBo9Z9Muy/o/ra0J0LYSE13y31/Oun4W1cqmyx+9\nvRMpJ1ihAygk7b9Xk2lbd6SzcgADi10qez5yffUr55Cp5rYmviM2aq/tLeKTDRHg\nRAIsDzO/bcVwdxNaDeRZB+BhMQKBgQDA/HhC4RZYMfLRQu+RuA60wQIQDnJMFCsC\nYz1dCkGnkzcs8V35HLKF1Xdtj4pXV4RjXD2mJ/yl/K8MADz3ymiB0N+HoyoIXzhV\nKqcl7Be6Xma52QeGlmJ58GOQV0xUdfS+X/32KuVQL0WgFT8xu7QCzJ6zOqkDNSI5\neGIRvsvtHwKBgQDCQ6yipxZuOxXVlx9sMSJsmoDKENaBnQ6rTU1toeaXcjQit1+O\nSPICdSmwkqUIiFVD/pi86gHxMn8pn7gF992r3mR5tyNjdPupETivUWgmGKTicsnK\nstT9V+B9egDB/EWY7/QRGmx8Z7hzzMd4AF5Uyr6/mqrVQU9lFxHQjAq9QQKBgC/V\nZCmPiO5LUxgzMxY3PM3omQ5JxmK9DPwGhQsuo59Zie+F0/kO9+DcTEHHtk53zsSh\n9FXey2yI+QpMdNAmR0kF8KG5+40frOLPM6beofL7uxKNjKP7WmVHBCaevLiilAsr\n19LQRw5c6TEIkyVMlQ2skhlyjLnSzazY/dXQKNOZAoGASEjNo8J0yoeuc6PDpHQC\nWlvPNvyVjw4m+jF7aNA+sLbtaGsw+8Um1d1Kj4XlU57T18WmwAc8RvzxKJDe/ZVD\n9qhckYKgIcjGy2mnf2F3ypZy/oGNqSjnX9xP1TB2sL96+KdVvYxjh5rKqMrluGbu\nrpPEBj2ycZGXQ+b1TIwiS8g=\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-fbsvc@lumere-app-fc2e2.iam.gserviceaccount.com",
    "client_id": "100230754562612438944",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
  });

  static const scope = ["https://www.googleapis.com/auth/firebase.messaging"];

  Future<String> AccessToken() async {
    final clinet = await clientViaServiceAccount(
      _ServiceAccountCredentials,
      scope,
    );
    final token = clinet.credentials.accessToken.data;
    clinet.close();
    return token;
  }

  Future<String?> getAdminToken() async {
    try {
      var snapshot = await _firestore
          .collection("users")
          .where("role", isEqualTo: "admin")
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data()["DeviceToken"];
      }
      return null;
    } catch (e) {
      print("فشل الحصول على توكن الادمن: ${e.toString()}");
      return null;
    }
  }

  Future<List<String>> getAllUsersTokens() async {
    try {
      var snapshot = await _firestore.collection("users").get();
      List<String> tokens = [];
      for (var doc in snapshot.docs) {
        String? token = doc.data()["DeviceToken"];
        if (token != null && token.isNotEmpty) {
          tokens.add(token);
          print("Token User: $token");
        }
      }
      return tokens;
    } catch (e) {
      print("فشل الحصول على توكن المستخدمين: ${e.toString()}");
      return [];
    }
  }

  Future<void> sendDirectNotificationt(Notification notification) async {
    final String url =
        "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";
    try {
      final accesstokken = await AccessToken();
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accesstokken',
        },
        body: jsonEncode({
          'message': {
            "token": notification.receiverId,
            "notification": {
              "title": notification.title,
              "body": notification.body,
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "status": "new_order",
            },
          },
        }),
      );
      if (response.statusCode != 200) {
        print("Error sending direct notification: ${response.body}");
      }
    } catch (e) {
      throw Exception("فشل ارسال الاشعار: ${e.toString()}");
    }
  }

  Future<void> SendToAllUsers({
    required String title,
    required String body,
  }) async {
    final String url =
        "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";
    try {
      final accesstokken = await AccessToken();
      
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accesstokken',
        },
        body: jsonEncode({
          'message': {
            'topic': 'all_users',
            "notification": {"title": title, "body": body},
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "status": "new_order",
            },
          },
        }),
      );
      
      if (response.statusCode != 200) {
        print("Error sending to all users: ${response.body}");
      }
    } catch (e) {
      throw Exception("فشل ارسال الاشعار: ${e.toString()}");
    }
  }
}
