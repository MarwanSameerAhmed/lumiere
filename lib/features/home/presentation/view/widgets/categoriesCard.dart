import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';

class Categoriescard extends StatelessWidget {
  final String Title;
  final bool isSelected;

  const Categoriescard({
    super.key,
    required this.Title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(15),
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isSelected
            ? AppColors.KPrimaryBackgroundColor
            : Color(0xffF0EDE4),
        border: isSelected
            ? null
            : Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.category,
            color: isSelected
                ? Color(0xffC9A962)
                : AppColors.KPrimaryBackgroundColor,
          ),
          SizedBox(height: 5),
          Text(
            Title,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : AppColors.KPrimaryBackgroundColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
