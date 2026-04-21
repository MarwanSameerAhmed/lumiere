import 'package:flutter/material.dart';
import 'package:lumiere/features/home/presentation/view/widgets/categoriesCard.dart';

class CategoriesSection extends StatefulWidget {
  CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  int selectedindex = 0;

  final List categories = ["Apparel", 'Jewellery', 'Beauty', 'Bags'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedindex = index;
              });
            },
            child: Categoriescard(
              Title: categories[index],
              isSelected: selectedindex == index,
            ),
          );
        },
      ),
    );
  }
}
