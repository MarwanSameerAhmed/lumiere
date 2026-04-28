import 'package:flutter/material.dart';
import 'package:lumiere/features/admin/data/repo/adminRepo.dart';
import 'package:lumiere/features/home/data/models/categorys.dart';
import 'package:lumiere/features/home/data/models/product.dart';

class Adminprovider extends ChangeNotifier {
  final AdminRepo _adminRepo = AdminRepo();
  final List<Categorys> cat = [];
  final List<Products> pro = [];
  bool isLoadingPro = false;
  bool isLoadingCat = false;
  String? errorMessage = null;

  Future<bool> addProduct(Products product) async {
    isLoadingPro = true;
    notifyListeners();
    try {
      await _adminRepo.addProduct(product);
      errorMessage = null;
      isLoadingPro = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoadingPro = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct(
    String productId,
    Map<String, dynamic> data,
  ) async {
    isLoadingPro = true;
    notifyListeners();
    try {
      await _adminRepo.updateProduct(productId, data);
      errorMessage = null;
      isLoadingPro = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoadingPro = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    isLoadingPro = true;
    notifyListeners();
    try {
      await _adminRepo.deleteProduct(productId);
      errorMessage = null;
      isLoadingPro = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoadingPro = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> addCategory(Categorys category) async {
    isLoadingCat = true;
    notifyListeners();
    try {
      await _adminRepo.addCategory(category);
      errorMessage = null;
      isLoadingCat = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoadingCat = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateCategories(
    String CategoryId,
    Map<String, dynamic> data,
  ) async {
    isLoadingPro = true;
    notifyListeners();
    try {
      await _adminRepo.updateCategories(CategoryId, data);
      errorMessage = null;
      isLoadingPro = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoadingPro = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCategory(String categoryId) async {
    isLoadingCat = true;
    notifyListeners();
    try {
      await _adminRepo.deleteCategory(categoryId);
      errorMessage = null;
      isLoadingCat = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoadingCat = false;
      notifyListeners();
      return false;
    }
  }
}
