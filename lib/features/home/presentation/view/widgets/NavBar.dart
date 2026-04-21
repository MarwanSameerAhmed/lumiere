import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lumiere/core/constants/colors.dart';

class Navbar extends StatelessWidget {
  final Function(int) onChange;
  final int currentIndex;
  const Navbar({super.key, required this.onChange, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(color: Colors.white, blurRadius: 10, offset: Offset(0, -5)),
        ],
      ),
      child: GNav(
        selectedIndex: currentIndex,
        color: Colors.grey[600],
        activeColor: Colors.white,
        tabBackgroundColor: AppColors.KPrimaryBackgroundColor,
        padding: EdgeInsets.all(16),
        tabs: [
          GButton(icon: Icons.home_filled, text: "Home"),
          GButton(icon: Icons.search, text: "Search"),
          GButton(icon: Icons.shopping_bag_outlined, text: "Cart"),
          GButton(icon: Icons.account_circle_outlined, text: "Orders"),
        ],
        onTabChange: onChange,
      ),
    );
  }
}
