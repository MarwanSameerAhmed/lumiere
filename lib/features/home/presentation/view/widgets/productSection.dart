import 'package:flutter/material.dart';
import 'package:lumiere/features/home/presentation/view/widgets/productCard.dart';

class Productsection extends StatelessWidget {
  const Productsection({super.key});

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
      itemCount: 4,
      itemBuilder: (context, index) {
        return Productcard(
          title: "Maison Satin Tote",
          price: "234",
          imageUrl: "assets/images.jpg",
        );
      },
    );
  }
}
