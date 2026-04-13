import 'package:flutter/widgets.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/features/auth/presentation/view/pages/login.dart';
import 'package:lumiere/features/auth/presentation/view/pages/resetpassword.dart';
import 'package:lumiere/features/auth/presentation/view/pages/signUp.dart';
import 'package:lumiere/features/auth/presentation/view/pages/test.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    AppRouter.login: (context) => LoginPage(),
    AppRouter.signUp: (context) => SignupPage(),
    AppRouter.home: (context) => Home(),
    AppRouter.resetpassword: (context) => Resetpassword(),
  };
}
