import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumiere/core/constants/fonts.dart';
import 'package:lumiere/features/auth/presentation/view/pages/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: AppFonts.MainFont),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
