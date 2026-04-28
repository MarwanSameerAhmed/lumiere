import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';

class Adminmanagementcards extends StatelessWidget {
  final String Title;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  const Adminmanagementcards({
    super.key,
    required this.Title,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12),
          color: color.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.KMainBackgroundButtonColor),
            SizedBox(height: 10),
            Text(
              Title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
