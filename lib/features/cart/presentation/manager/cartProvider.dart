import 'package:flutter/material.dart';
import 'package:lumiere/features/cart/data/models/cartItem.dart';
import 'package:lumiere/features/cart/data/repo/cartRepo.dart';

class CartProvider extends ChangeNotifier {
  final Cartrepo _cartrepo = Cartrepo();
  bool isLoading = false;
  String? errorMassage;
  List<CartItem> cartItems = [];

  // إجمالي السعر
  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  // عدد العناصر في السلة
  int get itemCount => cartItems.length;

  // جلب عناصر السلة
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

  // إضافة عنصر للسلة (أو زيادة الكمية إذا موجود)
  Future<bool> addToCart(String userId, CartItem item) async {
    try {
      // نشيك إذا المنتج موجود بالسلة
      int existingIndex = cartItems.indexWhere((e) => e.id == item.id);
      if (existingIndex != -1) {
        // موجود - نزيد الكمية
        CartItem updated = cartItems[existingIndex].copyWith(
          quantity: cartItems[existingIndex].quantity + item.quantity,
        );
        await _cartrepo.UpdateCart(userId, updated);
        cartItems[existingIndex] = updated;
      } else {
        // جديد - نضيفه
        await _cartrepo.UpdateCart(userId, item);
        cartItems.add(item);
      }
      notifyListeners();
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    }
  }

  // تحديث عنصر في السلة
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

  // زيادة الكمية
  Future<bool> incrementQuantity(String userId, String itemId) async {
    int index = cartItems.indexWhere((e) => e.id == itemId);
    if (index != -1) {
      CartItem updated = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + 1,
      );
      return await updateCart(userId, updated);
    }
    return false;
  }

  // تقليل الكمية
  Future<bool> decrementQuantity(String userId, String itemId) async {
    int index = cartItems.indexWhere((e) => e.id == itemId);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        CartItem updated = cartItems[index].copyWith(
          quantity: cartItems[index].quantity - 1,
        );
        return await updateCart(userId, updated);
      } else {
        // الكمية 1، نحذف العنصر
        return await removeFromCart(userId, itemId);
      }
    }
    return false;
  }

  // حذف عنصر من السلة
  Future<bool> removeFromCart(String userId, String itemId) async {
    try {
      await _cartrepo.deletecartItem(userId, itemId);
      cartItems.removeWhere((e) => e.id == itemId);
      notifyListeners();
      return true;
    } catch (e) {
      errorMassage = e.toString();
      return false;
    }
  }

  // تفريغ السلة محلياً (بعد إتمام الطلب)
  void clearCartLocally() {
    cartItems.clear();
    notifyListeners();
  }
}
