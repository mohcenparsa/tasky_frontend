import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? value;
  final List<String> options;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String labelText;

  const CustomDropdownFormField({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.validator,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.black),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          value: value,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
