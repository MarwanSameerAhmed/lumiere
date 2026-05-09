import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/features/admin/presentaion/view/pages/OrdersManagement/adminOrdersManagement.dart';
import 'package:lumiere/features/admin/presentaion/view/pages/adminDashboard.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/NavBar.dart';
import 'package:lumiere/features/cart/presentation/view/pages/cart.dart';
import 'package:lumiere/features/home/presentation/view/pages/home.dart';
import 'package:lumiere/features/orders/presentation/view/pages/customerOrdersDashboard.dart';
import 'package:lumiere/features/home/presentation/view/widgets/NavBar.dart';

class MainlayoutAdmin extends StatefulWidget {
  const MainlayoutAdmin({super.key});

  @override
  State<MainlayoutAdmin> createState() => _MainlayoutAdminState();
}

class _MainlayoutAdminState extends State<MainlayoutAdmin> {
  int _SelectedIndex = 0;
  final List<Widget> _pages = [
    Admindashboard(),
    AdminOrdersManagement(),
    Center(child: Text("setting Page")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: _pages[_SelectedIndex],
      bottomNavigationBar: NavbarAdmin(
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
