import 'package:flutter/material.dart';

class Adminmanagementheader extends StatelessWidget {
  final String Title;
  Adminmanagementheader({super.key, required this.Title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good morning,",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Text(Title, style: TextStyle(fontSize: 30)),
          ],
        ),
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
