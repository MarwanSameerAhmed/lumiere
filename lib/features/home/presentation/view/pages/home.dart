import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/features/home/presentation/view/widgets/carousel.dart';
import 'package:lumiere/features/home/presentation/view/widgets/categoriesSection.dart';
import 'package:lumiere/features/home/presentation/view/widgets/productSection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffF0EDE4),
                        ),
                        child: CircleAvatar(radius: 16),
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
              CategoriesSection(),
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
              Productsection(),
            ],
          ),
        ),
      ),
    );
  }
}
