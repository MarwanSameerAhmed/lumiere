import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lumiere/features/home/data/models/categorys.dart';
import 'package:lumiere/features/home/data/models/product.dart';

class Homerepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get all categroies
  Future<List<Categorys>> fetchAllCategories() async {
    final sanpShot = await _firestore.collection('categoryies').get();
    return sanpShot.docs.map((doc) => Categorys.fromJson(doc.data())).toList();
  }

  //get all products
  Future<List<Products>> fetchAllProduct() async {
    final sanpShot = await _firestore.collection('products').get();
    return sanpShot.docs.map((doc) => Products.fromJson(doc.data())).toList();
  }

  Future<List<Products>> fetchProductsByCategory(String CategroyId) async {
    if (CategroyId == "all") return await fetchAllProduct();

    final snapShot = await FirebaseFirestore.instance
        .collection("products")
        .where('CategoryId', isEqualTo: CategroyId)
        .get();

    return snapShot.docs.map((doc) => Products.fromJson(doc.data())).toList();
  }
}
