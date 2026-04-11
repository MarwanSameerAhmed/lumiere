import 'package:flutter/material.dart';

class Customdivider extends StatelessWidget {
  const Customdivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 10),
            child: Divider(color: Colors.grey.withOpacity(0.5), thickness: 1),
          ),
        ),
        Padding(padding: const EdgeInsets.all(15.0), child: Text("or")),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 5),
            child: Divider(color: Colors.grey.withOpacity(0.5), thickness: 1),
          ),
        ),
      ],
    );
  }
}
