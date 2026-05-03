import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/adminManagementHeader.dart';
import 'package:lumiere/features/cart/presentation/view/widgets/CartCard.dart';
import 'package:lumiere/features/cart/presentation/view/widgets/summrySection.dart';

class cart extends StatelessWidget {
  const cart({super.key});

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

            Expanded(
              child: ListView.builder(
                itemCount: 2, // Replace with actual item count
                itemBuilder: (context, index) {
                  return Cartcard();
                },
              ),
            ),
            Summrysection(),
          ],
        ),
      ),
    );
  }
}
