import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/widgets/massageToast.dart';
import 'package:lumiere/features/cart/data/models/cartItem.dart';
import 'package:lumiere/features/cart/presentation/manager/cartProvider.dart';
import 'package:lumiere/features/home/data/models/product.dart';
import 'package:provider/provider.dart';

class Productdetailes extends StatefulWidget {
  final Products products;

  const Productdetailes({super.key, required this.products});

  @override
  State<Productdetailes> createState() => _ProductdetailesState();
}

class _ProductdetailesState extends State<Productdetailes> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: _buildCircleButton(Icons.arrow_back_ios_new),
                  ),
                  const Text(
                    "Product Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  _buildCircleButton(Icons.more_horiz),
                ],
              ),
              const SizedBox(height: 20),
              Hero(
                tag: widget.products.Uid,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: MemoryImage(
                        base64Decode(widget.products.imageUrl),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.products.ProductName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Text(
                widget.products.Description,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_quantity > 1) {
                              setState(() => _quantity--);
                            }
                          },
                          child: _buildQtyBtn(Icons.remove),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => _quantity++);
                          },
                          child: _buildQtyBtn(Icons.add, isBlack: true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text(
                "\$${widget.products.price}",
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.black87,
                  height: 1.5,
                  fontSize: 30,
                ),
              ),

              const Spacer(),
              Row(
                children: [
                  // Buy Now = أضف للسلة + روح للسلة
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _addToCart(context, goToCart: true),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            "Buy Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Add to Cart
                  GestureDetector(
                    onTap: () => _addToCart(context),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _addToCart(BuildContext context, {bool goToCart = false}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final cartItem = CartItem(
      id: widget.products.Uid,
      name: widget.products.ProductName,
      imageUrl: widget.products.imageUrl,
      price: double.tryParse(widget.products.price) ?? 0.0,
      quantity: _quantity,
    );

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final success = await cartProvider.addToCart(userId, cartItem);

    if (success && context.mounted) {
      Massagetoast.show(msg: "Added to cart ✅", isError: false);
      if (goToCart) {
        // الرجوع للـ MainLayout والتنقل لتاب السلة
        Navigator.pop(context, 'goToCart');
      }
    } else if (context.mounted) {
      Massagetoast.show(msg: "Failed to add to cart", isError: true);
    }
  }

  Widget _buildCircleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xffF0EDE4),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black87, size: 18),
    );
  }

  Widget _buildQtyBtn(IconData icon, {bool isBlack = false}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isBlack ? Colors.black : Colors.transparent,
        shape: BoxShape.circle,
        border: isBlack ? null : Border.all(color: Colors.black12),
      ),
      child: Icon(icon, size: 16, color: isBlack ? Colors.white : Colors.black),
    );
  }
}
