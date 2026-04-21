import 'package:flutter/widgets.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/core/widgets/splashPage.dart';
import 'package:lumiere/features/auth/presentation/view/pages/login.dart';
import 'package:lumiere/features/auth/presentation/view/pages/resetpassword.dart';
import 'package:lumiere/features/auth/presentation/view/pages/signUp.dart';
import 'package:lumiere/features/auth/presentation/view/pages/test.dart';
import 'package:lumiere/features/home/presentation/view/pages/home.dart';
import 'package:lumiere/features/home/presentation/view/widgets/MainLayout.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    AppRouter.login: (context) => LoginPage(),
    AppRouter.signUp: (context) => SignupPage(),
    AppRouter.HomePage: (context) => HomePage(),
    AppRouter.resetpassword: (context) => Resetpassword(),
    AppRouter.Splashpage: (context) => Splashpage(),
    AppRouter.Mainlayout: (context) => Mainlayout(),
  };
}
