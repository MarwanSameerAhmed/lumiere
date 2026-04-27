import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lumiere/features/home/data/models/categorys.dart';
import 'package:lumiere/features/home/data/models/product.dart';
import 'package:lumiere/features/home/data/repo/homeRepo.dart';

class Homeprovider extends ChangeNotifier {
  final Homerepo _homerepo = Homerepo();
  List<Products> product = [];
  List<Categorys> category = [];
  bool isLoadingcat = false;
  bool isLoadingpro = false;

  String? errorMassage;

  Future<bool> fetchAllCategoryies() async {
    isLoadingcat = true;
    errorMassage = null;
    notifyListeners();
    try {
      var cat = await _homerepo.fetchAllCategories();
      category = cat;
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    } finally {
      isLoadingcat = false;
      notifyListeners();
    }
  }

  Future<bool> fetchAllProduct() async {
    isLoadingpro = true;
    errorMassage = null;
    notifyListeners();
    try {
      var pro = await _homerepo.fetchAllProduct();
      product = pro;
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    } finally {
      isLoadingpro = false;
      notifyListeners();
    }
  }

  Future<bool> filterProductbyCategory(String CategoryId) async {
    isLoadingpro = true;
    errorMassage = null;
    notifyListeners();
    try {
      var pro = await _homerepo.fetchProductsByCategory(CategoryId);
      product = pro;
      return true;
    } catch (e) {
      errorMassage.toString();
      return false;
    } finally {
      isLoadingpro = false;
      notifyListeners();
    }
  }
}
