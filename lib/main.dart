import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumiere/core/constants/fonts.dart';
import 'package:lumiere/core/network/Fcm_Service.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/core/routes/routes.dart';
import 'package:lumiere/features/admin/presentaion/manager/AdminProvider.dart';
import 'package:lumiere/features/auth/presentation/managers/auth_provider.dart';
import 'package:lumiere/features/auth/presentation/view/pages/login.dart';
import 'package:lumiere/features/home/data/models/categorys.dart';
import 'package:lumiere/features/home/data/models/product.dart';
import 'package:lumiere/features/home/data/repo/homeRepo.dart';
import 'package:lumiere/features/home/presentation/manager/homeProvider.dart';
import 'package:lumiere/features/notifications/presentaion/manager/notificationProvider.dart';
import 'package:lumiere/features/orders/presentation/manager/orderProvider.dart';
import 'package:lumiere/features/cart/presentation/manager/cartProvider.dart';
import 'package:lumiere/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FcmService.initFCM();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authprovider()),
        ChangeNotifierProvider(create: (_) => Homeprovider()),
        ChangeNotifierProvider(create: (_) => Adminprovider()),
        ChangeNotifierProvider(create: (_) => Notificationprovider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: AppFonts.MainFont),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.Splashpage,
      routes: AppRoutes.routes,
    );
  }
}
