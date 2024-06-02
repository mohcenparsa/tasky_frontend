import 'package:flutter/material.dart';
import 'package:tasky/config/app_config.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktopLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget layout;
        if (constraints.maxWidth > AppConfig.maxWidth) {
          // Desktop layout
          layout = desktopLayout;
        } else if (constraints.maxWidth > 800) {
          // Tablet layout
          layout = tabletLayout;
        } else {
          // Mobile layout
          layout = mobileLayout;
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: layout,
          ),
        );
      },
    );
  }
}
