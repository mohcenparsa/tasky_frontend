import 'package:flutter/material.dart';

import 'decorations.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool readOnly;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          decoration: inputDecoration(labelText: labelText),
          keyboardType: keyboardType,
          validator: validator,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
