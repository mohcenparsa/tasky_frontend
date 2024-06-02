import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/flutter_logo.png",
      height: height ?? 100,
      width: width ?? 100,
    );
  }
}
