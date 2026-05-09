import 'package:flutter/widgets.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/core/widgets/splashPage.dart';
import 'package:lumiere/core/widgets/warpper.dart';
import 'package:lumiere/features/admin/presentaion/view/pages/CategoryiesManagements/AddNewCategory.dart';
import 'package:lumiere/features/admin/presentaion/view/pages/CategoryiesManagements/adminCategoryiesManagement.dart';
import 'package:lumiere/features/admin/presentaion/view/pages/ProductsManagements/AddNewProduct.dart';
import 'package:lumiere/features/admin/presentaion/view/pages/adminDashboard.dart';
import 'package:lumiere/features/admin/presentaion/view/pages/OrdersManagement/adminOrdersManagement.dart';
import 'package:lumiere/features/admin/presentaion/view/pages/ProductsManagements/adminProductManagement.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/MainLayout.dart';
import 'package:lumiere/features/auth/presentation/view/pages/login.dart';
import 'package:lumiere/features/auth/presentation/view/pages/resetpassword.dart';
import 'package:lumiere/features/auth/presentation/view/pages/signUp.dart';
import 'package:lumiere/features/auth/presentation/view/pages/test.dart';
import 'package:lumiere/features/home/presentation/view/pages/home.dart';
import 'package:lumiere/features/home/presentation/view/widgets/MainLayout.dart';
import 'package:lumiere/features/home/presentation/view/widgets/productdetailes.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    AppRouter.login: (context) => LoginPage(),
    AppRouter.signUp: (context) => SignupPage(),
    AppRouter.HomePage: (context) => HomePage(),
    AppRouter.resetpassword: (context) => Resetpassword(),
    AppRouter.Splashpage: (context) => Splashpage(),
    AppRouter.Mainlayout: (context) => Mainlayout(),
    AppRouter.productManagement: (context) => productManagement(),
    AppRouter.Warpper: (context) => Warpper(),
    AppRouter.Admindashboard: (context) => Admindashboard(),
    AppRouter.Addnewproduct: (context) => Addnewproduct(),
    AppRouter.AdminCategoriesManagement: (context) =>
        AdminCategoriesManagement(),
    AppRouter.Addnewcategory: (context) => Addnewcategory(),
    AppRouter.AdminOrdersManagement: (context) => AdminOrdersManagement(),
    AppRouter.MainlayoutAdmin: (context) => MainlayoutAdmin(),
  };
}
