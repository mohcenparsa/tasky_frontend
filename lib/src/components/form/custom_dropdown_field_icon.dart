import 'package:flutter/material.dart';

class CustomDropdownFormFieldWithIcon extends StatelessWidget {
  final String? value;
  final List<Map<String, String>> options;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String labelText;

  const CustomDropdownFormFieldWithIcon({
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
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option['value'],
              child: Row(
                children: [
                  Image.asset(
                    option['imageUrl']!,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Text(option['value']!),
                ],
              ),
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
