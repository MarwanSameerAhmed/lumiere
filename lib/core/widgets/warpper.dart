import 'package:flutter/material.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/core/routes/routes.dart';
import 'package:lumiere/features/auth/presentation/managers/auth_provider.dart';
import 'package:lumiere/features/home/presentation/manager/homeProvider.dart';

class Warpper extends StatefulWidget {
  const Warpper({super.key});

  @override
  State<Warpper> createState() => _WarpperState();
}

class _WarpperState extends State<Warpper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRole();
  }

  Future<void> checkRole() async {
    final Warpper = Authprovider();
    String role = await Warpper.getUserRoleProvider();
    if (role == 'admin') {
      Navigator.pushNamed(context, AppRouter.Admindasboard);
    } else {
      Navigator.pushNamed(context, AppRouter.Mainlayout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
