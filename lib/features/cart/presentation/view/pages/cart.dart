import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/adminManagementHeader.dart';
import 'package:lumiere/features/cart/presentation/manager/cartProvider.dart';
import 'package:lumiere/features/cart/presentation/view/widgets/cardCart.dart';
import 'package:lumiere/features/cart/presentation/view/widgets/summrySection.dart';
import 'package:provider/provider.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCart();
    });
  }

  void _loadCart() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      Provider.of<CartProvider>(context, listen: false).fetchCartItems(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 20,
              ),
              child: Adminmanagementheader(Title: "Cart"),
            ),

            // قائمة عناصر السلة
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  if (cartProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (cartProvider.errorMassage != null &&
                      cartProvider.cartItems.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 50,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Failed to load cart',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _loadCart,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.KMainBackgroundButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (cartProvider.cartItems.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: const BoxDecoration(
                              color: Color(0xffF0EDE4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 50,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Your cart is empty',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add items to start shopping',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      return cardCart(item: cartProvider.cartItems[index]);
                    },
                  );
                },
              ),
            ),

            // ملخص الأسعار وزر Checkout
            const Summrysection(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
