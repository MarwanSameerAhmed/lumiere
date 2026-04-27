import 'package:flutter/material.dart';
import 'package:lumiere/features/home/data/models/categorys.dart';
import 'package:lumiere/features/home/presentation/manager/homeProvider.dart';
import 'package:lumiere/features/home/presentation/view/widgets/categoriesCard.dart';
import 'package:provider/provider.dart';

class CategoriesSection extends StatefulWidget {
  final List<Categorys> cat;
  CategoriesSection({super.key, required this.cat});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.cat.length,
        itemBuilder: (context, index) {
          final category = widget.cat[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedindex = index;
              });
              final homepro = Provider.of<Homeprovider>(context, listen: false);
              homepro.filterProductbyCategory(category.ID);
            },

            child: Categoriescard(
              Title: widget.cat[index].name,
              isSelected: selectedindex == index,
              icons: widget.cat[index].icon,
            ),
          );
        },
      ),
    );
  }
}
