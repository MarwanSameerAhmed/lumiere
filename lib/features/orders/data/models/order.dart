import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderStatus { pending, accepted, completed, cancelled }

class OrderModel {
  final String orderId;
  final String userId;
  final String userName;
  final List<dynamic> items;
  final double totalPrice;
  final OrderStatus status;
  final DateTime createdAt;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'userName': userName,
      'items': items,
      'totalPrice': totalPrice,
      'status': status.name,
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      items: map['items'] ?? [],
      totalPrice: (map['totalPrice'] as num).toDouble(),
      status: OrderStatus.values.byName(map['status'] ?? 'pending'),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
