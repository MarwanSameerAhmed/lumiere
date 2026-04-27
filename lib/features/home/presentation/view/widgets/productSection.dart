import 'package:flutter/material.dart';
import 'package:lumiere/features/home/data/models/product.dart';
import 'package:lumiere/features/home/presentation/view/widgets/productCard.dart';
import 'package:lumiere/features/home/presentation/view/widgets/productdetailes.dart';

class Productsection extends StatefulWidget {
  final List<Products> products;
  const Productsection({super.key, required this.products});

  @override
  State<Productsection> createState() => _ProductsectionState();
}

class _ProductsectionState extends State<Productsection> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 15,
        childAspectRatio: 0.7,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        return Productcard(products: widget.products[index]);
      },
    );
  }
}
