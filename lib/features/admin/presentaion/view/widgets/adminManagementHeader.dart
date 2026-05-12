import 'package:flutter/material.dart';

class Adminmanagementheader extends StatelessWidget {
  final String Title;
  final bool showBackButton;

  Adminmanagementheader({
    super.key,
    required this.Title,
    this.showBackButton = true, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good morning,",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Text(Title, style: const TextStyle(fontSize: 30)),
          ],
        ),
        if (showBackButton!)
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: _buildCircleButton(Icons.arrow_forward_ios),
          ),
      ],
    );
  }

  Widget _buildCircleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xffF0EDE4),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black87, size: 18),
    );
  }
}
