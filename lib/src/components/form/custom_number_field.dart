import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'decorations.dart';

class CustomNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool readOnly;
  final String? Function(String?)? validator;

  const CustomNumberField({
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
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: inputDecoration(labelText: labelText),
          keyboardType: keyboardType,
          validator: validator,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
