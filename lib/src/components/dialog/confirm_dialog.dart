import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String confirmText;
  final String cancelText;
  final String confirmDialogTitle;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.confirmText,
    required this.cancelText,
    required this.confirmDialogTitle,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(confirmDialogTitle),
      content: const Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            onConfirm();
          },
          child: Text(confirmText, style: const TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
