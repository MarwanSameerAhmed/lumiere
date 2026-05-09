import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lumiere/features/orders/data/models/order.dart';

class OrderRepo {
  final _firestore = FirebaseFirestore.instance;

  Future<void> placeOrder(OrderModel order) async {
    try {
      await _firestore
          .collection('orders')
          .doc(order.orderId)
          .set(order.toMap());

      await _clearCart(order.userId);
    } catch (e) {
      throw Exception("فشل إتمام الطلب: $e");
    }
  }

  Future<List<OrderModel>> fetchAllOrders() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("فشل جلب الطلبات: $e");
    }
  }

  Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("فشل جلب طلباتك: $e");
    }
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': status.name,
      });
    } catch (e) {
      throw Exception("فشل تحديث حالة الطلب: $e");
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
    } catch (e) {
      throw Exception("فشل حذف الطلب: $e");
    }
  }

  Future<void> _clearCart(String userId) async {
    var cartItems = await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get();
    for (var doc in cartItems.docs) {
      await doc.reference.delete();
    }
  }
}
