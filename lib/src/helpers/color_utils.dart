// lib/utils/color_utils.dart

import 'package:flutter/material.dart';

Color getPriorityColor(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return Colors.red;
    case 'medium':
      return Colors.orange;
    case 'low':
      return Colors.blue;
    default:
      return Colors.grey;
  }
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'waiting':
      return Colors.pink;
    case 'inprogress':
      return Colors.blue;
    case 'finished':
      return Colors.green;
    default:
      return Colors.grey;
  }
}

// const Color primaryColor = Colors.black;
// const Color secondaryColor = Colors.purple;
// const Color backgroundColor = Colors.black12;
// const Color borderColor = Colors.black12;
// const TextStyle headerStyle =
//     TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
// const textStyle = TextStyle(fontSize: 16, color: backgroundColor);
// const boldText = TextStyle(
//     fontSize: 16, color: backgroundColor, fontWeight: FontWeight.bold);
