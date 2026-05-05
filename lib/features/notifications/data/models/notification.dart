class Notification {
  final String title;
  final String body;
  final String receiverId;

  Notification({
    required this.title,
    required this.body,
    required this.receiverId,
  });

  Map<String, dynamic> toMap() {
    return {
      "to": receiverId,
      "notification": {
        "title": title,
        "body": body,
        "sound": "default",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "status": "new_order",
        },
      },
    };
  }
}
