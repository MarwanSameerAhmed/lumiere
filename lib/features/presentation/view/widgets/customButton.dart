import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String BtnText;
  final IconData Icons;
  final VoidCallback onPressd;
  final Color Background;
  final Color foreBacground;
  const Custombutton({
    super.key,
    required this.BtnText,
    required this.Icons,
    required this.onPressd,
    required this.Background,
    required this.foreBacground,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          foregroundColor: foreBacground,
          backgroundColor: Background,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        onPressed: onPressd,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              BtnText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Icon(Icons),
          ],
        ),
      ),
    );
  }
}
