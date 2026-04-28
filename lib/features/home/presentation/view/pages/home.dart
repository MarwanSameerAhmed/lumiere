import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/core/routes/router.dart';
import 'package:lumiere/features/auth/data/repo/auth_repo.dart';
import 'package:lumiere/features/auth/presentation/managers/auth_provider.dart';
import 'package:lumiere/features/home/presentation/manager/homeProvider.dart';
import 'package:lumiere/features/home/presentation/view/widgets/carousel.dart';
import 'package:lumiere/features/home/presentation/view/widgets/categoriesSection.dart';
import 'package:lumiere/features/home/presentation/view/widgets/productSection.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final auth = Authprovider();

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      final homepro = Provider.of<Homeprovider>(context, listen: false);
      if (homepro.category.isEmpty) homepro.fetchAllCategoryies();
      if (homepro.product.isEmpty) homepro.fetchAllProduct();
    });
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good morning,",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text("Élise Moreau", style: TextStyle(fontSize: 30)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffF0EDE4),
                        ),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () async {
                          final succ = await auth.signout();
                          if (succ) {
                            Navigator.pushNamed(context, AppRouter.login);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xffF0EDE4),
                          ),
                          child: CircleAvatar(radius: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Carousel(),
              SizedBox(height: 25),
              Text(
                "CATEGORIES",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 25),
              Consumer<Homeprovider>(
                builder: (context, value, child) {
                  if (value.isLoadingcat) return CircularProgressIndicator();
                  if (value.errorMassage != null) {
                    return Column(
                      children: [
                        Text(value.errorMassage!),
                        ElevatedButton(
                          onPressed: () => value.fetchAllCategoryies(),
                          child: Text("إعادة المحاولة"),
                        ),
                      ],
                    );
                  }
                  if (value.category.isEmpty) {
                    return const Center(child: Text("No categroies found"));
                  }

                  return CategoriesSection(cat: value.category);
                },
              ),

              SizedBox(height: 25),
              Text(
                "TRENDING NOW",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 25),
              Consumer<Homeprovider>(
                builder: (context, value, child) {
                  if (value.isLoadingpro) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (value.errorMassage != null) {
                    return Center(
                      child: Column(
                        children: [
                          Text("Error: ${value.errorMassage}"),
                          IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () => value.fetchAllProduct(),
                          ),
                        ],
                      ),
                    );
                  }

                  if (value.product.isEmpty) {
                    return const Center(child: Text("No products found "));
                  }

                  return Productsection(products: value.product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
