import 'package:flutter/material.dart';

enum SnackBarType { success, warn }

class SnackMessage extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const SnackMessage({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      backgroundColor: type == SnackBarType.success ? Colors.green : Colors.red,
    );
  }
}
