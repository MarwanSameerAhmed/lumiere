import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lumiere/features/cart/data/models/cartItem.dart';

class Cartrepo {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<CartItem>> addCart(String userId) async {
    try {
      var snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();
      return snapshot.docs.map((doc) => CartItem.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception("Failed to fetch cart items: $e");
    }
  }

  Future<void> UpdateCart(String userId, CartItem item) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(item.id)
          .set(item.toMap());
    } catch (e) {
      throw Exception("Failed to add item to cart: $e");
    }
  }

  Future<void> deletecartItem(String userId, String ItemId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(ItemId)
          .delete();
    } catch (e) {
      throw Exception("Failed to delete item from cart: $e");
    }
  }
}
