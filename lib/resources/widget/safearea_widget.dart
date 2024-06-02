import 'package:flutter/material.dart';

class SafeAreaWidget extends StatelessWidget {
  final Widget child;
  const SafeAreaWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      child: child,
    );
  }
}
