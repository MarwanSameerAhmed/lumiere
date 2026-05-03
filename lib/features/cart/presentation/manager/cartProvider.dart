import 'package:flutter/material.dart';
import 'package:lumiere/features/cart/data/models/cartItem.dart';
import 'package:lumiere/features/cart/data/repo/cartRepo.dart';

class CartProvider extends ChangeNotifier {
  final Cartrepo _cartrepo = Cartrepo();
  bool isLoading = false;
  String? errorMassage;
  List<CartItem> cartItems = [];

  Future<bool> fetchCartItems(String userId) async {
    isLoading = true;
    errorMassage = null;
    notifyListeners();
    try {
      cartItems = await _cartrepo.addCart(userId);
      errorMassage = null;
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateCart(String userId, CartItem item) async {
    try {
      await _cartrepo.UpdateCart(userId, item);
      int index = cartItems.indexWhere((element) => element.id == item.id);
      if (index != -1) {
        cartItems[index] = item;
        notifyListeners();
      }
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    }
  }
}
