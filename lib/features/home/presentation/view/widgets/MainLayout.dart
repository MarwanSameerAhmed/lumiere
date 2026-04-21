import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/features/home/presentation/view/pages/home.dart';
import 'package:lumiere/features/home/presentation/view/widgets/NavBar.dart';

class Mainlayout extends StatefulWidget {
  const Mainlayout({super.key});

  @override
  State<Mainlayout> createState() => _MainlayoutState();
}

class _MainlayoutState extends State<Mainlayout> {
  int _SelectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    Center(child: Text("البحث")),
    Center(child: Text("السله")),
    Center(child: Text("الطلبات")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: _pages[_SelectedIndex],
      bottomNavigationBar: Navbar(
        onChange: (index) {
          setState(() {
            _SelectedIndex = index;
          });
        },
        currentIndex: _SelectedIndex,
      ),
    );
  }
}
