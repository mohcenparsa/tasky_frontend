import 'package:flutter/material.dart';

InputDecoration inputDecoration(
    {required String labelText, Widget? suffixIcon}) {
  return InputDecoration(
    hintStyle: const TextStyle(color: Colors.black12),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    labelText: labelText,
    filled: true,
    fillColor: Colors.white,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    suffixIcon: suffixIcon,
  );
}

BoxDecoration containerDecoration() {
  return BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
    color: Colors.white,
  );
}
