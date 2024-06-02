import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasky/config/app_config.dart';
import 'package:tasky/resources/widget/safearea_widget.dart';

class PageLayout extends StatelessWidget {
  final Widget child;

  const PageLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = kIsWeb || PlatformChecker.isWindows;
    double maxWidth = isDesktop ? AppConfig.maxWidth : double.infinity;
    return SafeAreaWidget(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        alignment: Alignment.center,
        child: Center(child: child),
      ),
    );
  }
}

class PlatformChecker {
  static bool get isWindows => false;
}
