import 'package:flutter/material.dart';
import 'package:lumiere/features/notifications/presentaion/manager/notificationProvider.dart';
import 'package:lumiere/features/orders/data/models/order.dart';
import 'package:lumiere/features/orders/data/repo/orderRepo.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepo _orderRepo = OrderRepo();
  bool isLoading = false;
  String? errorMessage;

  List<OrderModel> allOrders = [];
  List<OrderModel> userOrders = [];
  String? selectedStatusFilter;

  List<OrderModel> get filteredOrders {
    if (selectedStatusFilter == null || selectedStatusFilter == 'all') {
      return allOrders;
    }
    return allOrders
        .where((order) => order.status.name == selectedStatusFilter)
        .toList();
  }

  int get pendingCount =>
      allOrders.where((o) => o.status == OrderStatus.pending).length;
  int get acceptedCount =>
      allOrders.where((o) => o.status == OrderStatus.accepted).length;
  int get completedCount =>
      allOrders.where((o) => o.status == OrderStatus.completed).length;
  int get cancelledCount =>
      allOrders.where((o) => o.status == OrderStatus.cancelled).length;

  void setFilter(String? filter) {
    selectedStatusFilter = filter;
    notifyListeners();
  }

  Future<void> submitOrder(BuildContext context, OrderModel order) async {
    isLoading = true;
    notifyListeners();

    try {
      await _orderRepo.placeOrder(order);

      Provider.of<Notificationprovider>(context, listen: false).notifyAdmin(
        title: "طلب جديد 🚀",
        body: "قام ${order.userName} بطلب خدمات بقيمة ${order.totalPrice}\$",
      );

      print("تم الطلب وإشعار الأدمن بنجاح");
    } catch (e) {
      errorMessage = e.toString();
      print("خطأ في عملية الطلب: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> fetchAllOrders() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      allOrders = await _orderRepo.fetchAllOrders();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> fetchUserOrders(String userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      userOrders = await _orderRepo.fetchUserOrders(userId);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateOrderStatus(String orderId, OrderStatus status) async {
    isLoading = true;
    notifyListeners();
    try {
      await _orderRepo.updateOrderStatus(orderId, status);
      int idx = allOrders.indexWhere((o) => o.orderId == orderId);
      if (idx != -1) {
        allOrders[idx] = OrderModel(
          orderId: allOrders[idx].orderId,
          userId: allOrders[idx].userId,
          userName: allOrders[idx].userName,
          items: allOrders[idx].items,
          totalPrice: allOrders[idx].totalPrice,
          status: status,
          createdAt: allOrders[idx].createdAt,
        );
      }
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    isLoading = true;
    notifyListeners();
    try {
      await _orderRepo.deleteOrder(orderId);
      allOrders.removeWhere((o) => o.orderId == orderId);
      userOrders.removeWhere((o) => o.orderId == orderId);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
