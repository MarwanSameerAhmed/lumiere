import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lumiere/features/home/data/models/categorys.dart';
import 'package:lumiere/features/home/data/models/product.dart';

class AdminRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Products product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.Uid)
          .set(product.toMap());
    } catch (e) {
      throw Exception("Failed to add product: ${e.toString()}");
    }
  }

  Future<void> updateProduct(
    String productId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection('products').doc(productId).update(data);
    } catch (e) {
      throw Exception("Failed to update product: ${e.toString()}");
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (e) {
      throw Exception("Failed to delete product: ${e.toString()}");
    }
  }

  Future<void> addCategory(Categorys category) async {
    try {
      await _firestore
          .collection('categories')
          .doc(category.ID)
          .set(category.toMap());
    } catch (e) {
      throw Exception("Failed to add category: ${e.toString()}");
    }
  }

  Future<void> updateCategories(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection('categories').doc(categoryId).update(data);
    } catch (e) {
      throw Exception("Failed to update category: ${e.toString()}");
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestore.collection('categories').doc(categoryId).delete();
    } catch (e) {
      throw Exception("Failed to delete category: ${e.toString()}");
    }
  }
}
