import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
