import 'package:flutter/material.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/features/auth/presentation/managers/auth_provider.dart';
import 'package:provider/provider.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handler();
  }

  void _handler() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    Provider.of<Authprovider>(context, listen: false);
    if (Authprovider().CheckCurruntUser()) {
      Navigator.pushNamed(context, AppRouter.Mainlayout);
    } else {
      Navigator.pushNamed(context, AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/hero-area.png", width: 400, height: 400),
            SizedBox(height: 30),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
