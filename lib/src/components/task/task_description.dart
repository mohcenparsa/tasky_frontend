import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TaskDescription extends StatelessWidget {
  final String description;

  const TaskDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      description,
      style: const TextStyle(fontSize: 14),
      maxLines: 2,
      maxFontSize: 30,
    );
    // return Text(
    //   description,
    //   style: TextStyle(
    //     fontSize: 14,
    //     color: Colors.grey[600],
    //   ),
    //   overflow: TextOverflow.ellipsis,
    // );
  }
}
