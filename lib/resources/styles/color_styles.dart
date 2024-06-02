import 'package:flutter/material.dart';

/// Interface for defining base color styles in the application.
///
/// This abstract class outlines the color properties that need to be implemented
/// in different theme files, such as `light_theme_colors.dart` and `dark_theme_colors.dart`.
/// These styles include general colors, app bar colors, button colors, and bottom tab bar colors.

abstract class ColorStyles {
  /// * Available styles *

  /// The background color used throughout the application.
  @override
  Color get background;

  /// The primary content color, typically used for text or icons.
  @override
  Color get primaryContent;

  /// The primary accent color used for highlighting elements.
  @override
  Color get primaryAccent;

  /// The background color for surfaces like cards or dialogs.
  @override
  Color get surfaceBackground;

  /// The content color used on surface backgrounds.
  @override
  Color get surfaceContent;

  /// The background color for the app bar.
  @override
  Color get appBarBackground;

  /// The primary content color for the app bar, typically used for app bar text or icons.
  @override
  Color get appBarPrimaryContent;

  /// The background color for buttons.
  @override
  Color get buttonBackground;

  /// The primary content color for buttons, typically used for button text or icons.
  @override
  Color get buttonPrimaryContent;

  /// The background color for the bottom tab bar.
  @override
  Color get bottomTabBarBackground;

  /// The color for selected icons in the bottom tab bar.
  @override
  Color get bottomTabBarIconSelected;

  /// The color for unselected icons in the bottom tab bar.
  @override
  Color get bottomTabBarIconUnselected;

  /// The color for unselected labels in the bottom tab bar.
  @override
  Color get bottomTabBarLabelUnselected;

  /// The color for selected labels in the bottom tab bar.
  @override
  Color get bottomTabBarLabelSelected;
}
