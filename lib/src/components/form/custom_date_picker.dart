import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final String label;
  final void Function(DateTime pickedDate) onDatePicked;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.initialDate,
    required this.onDatePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        TextButton(
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              onDatePicked(pickedDate);
            }
          },
          child: Text(
            DateFormat('dd MMMM, yyyy').format(initialDate),
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
