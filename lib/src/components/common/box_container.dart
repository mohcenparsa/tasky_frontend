import 'package:flutter/material.dart';

class BoxContainer extends StatelessWidget {
  final Widget child;

  const BoxContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _containerDecoration(),
      child: child,
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.red),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    );
  }
}
