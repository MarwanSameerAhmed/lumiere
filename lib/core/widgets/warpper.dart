import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/features/auth/presentation/managers/auth_provider.dart';
import 'package:provider/provider.dart';

class Warpper extends StatefulWidget {
  const Warpper({super.key});

  @override
  State<Warpper> createState() => _WarpperState();
}

class _WarpperState extends State<Warpper> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkRole();
    });
  }

  Future<void> checkRole() async {
    final authProvider = Provider.of<Authprovider>(context, listen: false);
    String role = await authProvider.getUserRoleProvider();
    if (!mounted) return;
    if (role == 'admin') {
      Navigator.pushReplacementNamed(context, AppRouter.MainlayoutAdmin);
    } else {
      Navigator.pushReplacementNamed(context, AppRouter.Mainlayout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
