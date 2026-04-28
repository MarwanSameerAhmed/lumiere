import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumiere/core/constants/fonts.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/core/routes/routes.dart';
import 'package:lumiere/features/admin/presentaion/manager/AdminProvider.dart';
import 'package:lumiere/features/auth/presentation/managers/auth_provider.dart';
import 'package:lumiere/features/auth/presentation/view/pages/login.dart';
import 'package:lumiere/features/home/data/models/categorys.dart';
import 'package:lumiere/features/home/data/models/product.dart';
import 'package:lumiere/features/home/data/repo/homeRepo.dart';
import 'package:lumiere/features/home/presentation/manager/homeProvider.dart';
import 'package:lumiere/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  // await seedsdata();

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
      ],
      child: const Main(),
    ),
  );
}

// Future<void> seedsdata() async {
//   final repo = Homerepo();
//   List<Categorys> cats = [
//     Categorys(ID: '2', name: 'Shirt', icon: 'shirt'),
//     Categorys(ID: '3', name: 'bag', icon: 'bag'),
//     Categorys(ID: '1', name: 'bag', icon: 'bag'),

//     Categorys(ID: 'all', name: 'All', icon: 'all'),
//   ];
//   for (var cat in cats) {
//     await repo.addCategory(cat);
//   }

//   List<Products> prod = [
//     Products(
//       Uid: '1',
//       ProductName: 'sultan',
//       price: '200',
//       imageUrl: '',
//       CategoryId: 'all',
//       stock: 20,
//     ),
//     Products(
//       Uid: '2',
//       ProductName: 'sami',
//       price: '200',
//       imageUrl: '',
//       CategoryId: 'all',
//       stock: 20,
//     ),
//     Products(
//       Uid: '3',
//       ProductName: ' salah',
//       price: '200',
//       imageUrl: '',
//       CategoryId: '3',
//       stock: 20,
//     ),

//     Products(
//       Uid: '4',
//       ProductName: 'Ali ',
//       price: '200',
//       imageUrl: '',
//       CategoryId: '2',
//       stock: 20,
//     ),
//   ];

//   for (var pro in prod) {
//     await repo.addProduct(pro);
//   }

//   print('all cats added');
// }

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
