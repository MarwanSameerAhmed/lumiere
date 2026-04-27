import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lumiere/features/home/data/models/categorys.dart';
import 'package:lumiere/features/home/data/models/product.dart';

class Adminrepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Products products) async {
    await _firestore
        .collection('products')
        .doc(products.Uid)
        .set(products.toMap());
  }

  Future<void> updateProduct(
    String ProductId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection('product').doc(ProductId).update(data);
    } catch (e) {
      throw Exception("");
    }
  }

  Future<void> DeleteProduct(String ProductId) async {
    try {
      await _firestore.collection('products').doc(ProductId).delete();
    } on Exception catch (e) {}
  }

  Future<void> addCategory(Categorys categories) async {
    await _firestore
        .collection('categoryies')
        .doc(categories.ID)
        .set(categories.toMap());
  }
}
