import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/features/home/data/models/product.dart';

class Productdetailes extends StatelessWidget {
  final Products products;

  const Productdetailes({super.key, required this.products});
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
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    products.ProductName,
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
                products.Description,
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
                        _buildQtyBtn(Icons.remove),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildQtyBtn(Icons.add, isBlack: true),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text(
                products.price,
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.grey,
                  height: 1.5,
                  fontSize: 30,
                ),
              ),

              const Spacer(),
              Row(
                children: [
                  Expanded(
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
                  const SizedBox(width: 15),
                  Container(
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
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
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
