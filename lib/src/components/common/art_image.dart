import 'package:flutter/material.dart';

class ArtImage extends StatelessWidget {
  const ArtImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/task_art.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
