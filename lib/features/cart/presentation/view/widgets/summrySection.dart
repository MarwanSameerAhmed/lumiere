import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/widgets/massageToast.dart';
import 'package:lumiere/features/cart/presentation/manager/cartProvider.dart';
import 'package:lumiere/features/orders/data/models/order.dart';
import 'package:lumiere/features/orders/presentation/manager/orderProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Summrysection extends StatelessWidget {
  const Summrysection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border(top: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal (${cartProvider.itemCount} items)",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      "${cartProvider.totalPrice.toStringAsFixed(2)} SAR",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delivery",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      "Free",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${cartProvider.totalPrice.toStringAsFixed(2)} SAR",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff243352),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) {
                    if (orderProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: cartProvider.cartItems.isEmpty
                          ? null
                          : () =>
                                _checkout(context, cartProvider, orderProvider),
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: cartProvider.cartItems.isEmpty
                            ? Colors.grey.shade400
                            : AppColors.KMainBackgroundButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _checkout(
    BuildContext context,
    CartProvider cartProvider,
    OrderProvider orderProvider,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final orderItems = cartProvider.cartItems
        .map((item) => item.toMap())
        .toList();

    final order = OrderModel(
      orderId: const Uuid().v4(),
      userId: user.uid,
      userName: user.displayName ?? user.email ?? 'Customer',
      items: orderItems,
      totalPrice: cartProvider.totalPrice,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
    );

    await orderProvider.submitOrder(context, order);

    cartProvider.clearCartLocally();

    if (context.mounted) {
      Massagetoast.show(msg: "Order placed successfully! ✅", isError: false);
    }
  }
}
