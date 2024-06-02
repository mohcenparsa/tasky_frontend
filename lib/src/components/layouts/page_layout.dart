import 'package:flutter/material.dart';
import 'package:tasky/config/app_config.dart';

class PageLayout extends StatelessWidget {
  final Widget child;

  const PageLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: AppConfig.maxWidth,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.center,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      )),
    );
  }
}
