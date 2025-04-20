import 'package:flutter/material.dart';

class ColorManagers {
  // Primary Colors
  static const Color primaryColor =
      Color(0xFFC40C0C); // Primary color for the app
  static const Color onPrimaryColor =
      Colors.white; // Text/icon color on primary

  // Accent Colors
  static const Color green = Color(0Xff89AC46);
  static const Color grey = Color(0Xff3F4F44);
  static const Color blue = Color(0Xff3D90D7);

  // Secondary Colors
  static const Color secondaryColor =
      Color(0xFFFF6500); // Secondary color for the app
  static const Color onSecondaryColor =
      Colors.black; // Text/icon color on secondary

  // Background Colors
  static const Color backgroundColor =
      Color(0xffFF8A08); // Background color for light theme
  static const Color onBackgroundColor =
      Colors.black; // Text/icon color on background

  // Surface Colors
  static const Color surfaceColor =
      Color(0xffFFC100); // Surface color for light theme
  static const Color onSurfaceColor =
      Colors.black; // Text/icon color on surface

  // Error Colors
  static const Color errorColor = Colors.red; // Error color
  static const Color onErrorColor = Colors.white;
  static const Color moredarkBlue = Color(0xFF111827);

  static const Color darkBlue = Color(0xff102E50); // Text/icon color on error
}

// Light Theme Color Scheme
final ColorScheme lightColorScheme = ColorScheme.light(
  primary: ColorManagers.primaryColor,
  onPrimary: ColorManagers.onPrimaryColor,
  secondary: ColorManagers.secondaryColor,
  onSecondary: ColorManagers.onSecondaryColor,
  surface: ColorManagers.surfaceColor,
  onSurface: ColorManagers.onSurfaceColor,
  error: ColorManagers.errorColor,
  onError: ColorManagers.onErrorColor,
);

// Dark Theme Color Scheme
final ColorScheme darkColorScheme = ColorScheme.dark(
  primary: ColorManagers.primaryColor,
  onPrimary: ColorManagers.onPrimaryColor,
  secondary: ColorManagers.secondaryColor,
  onSecondary: ColorManagers
      .onSecondaryColor, // Text/icon color on background for dark theme
  surface: Color(0xFF121212), // Surface color for dark theme
  onSurface: Colors.white, // Text/icon color on surface for dark theme
  error: ColorManagers.errorColor,
  onError: ColorManagers.onErrorColor,
);
