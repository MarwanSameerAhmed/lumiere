import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final String HintText;
  final IconData perfix;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  const Customtextfield({
    super.key,
    required this.HintText,
    required this.perfix,
    required this.controller,
    required this.isPassword,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(perfix),
          hintText: HintText,
          hintStyle: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
