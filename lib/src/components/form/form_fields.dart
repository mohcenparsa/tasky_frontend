import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'decorations.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback toggleObscureText;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.toggleObscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: inputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: toggleObscureText,
            ),
          ),
          validator: validator,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;
  final String label;

  const SignUpButton({
    super.key,
    required this.label,
    required this.formKey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;
  final String label;

  const SubmitButton({
    super.key,
    required this.label,
    required this.formKey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class Redirect extends StatelessWidget {
  final String text;
  final String label;
  final String routeName;

  const Redirect({
    super.key,
    required this.text,
    required this.label,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, routeName);
          },
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
