import 'package:flutter/material.dart';

class LoginStyles {
  static const backgroundColor = Color(0xFFF1F4F8);

  static const titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF2E3A59),
  );

  static TextStyle subtitleStyle(Color? color) =>
      TextStyle(fontSize: 14, color: color ?? Colors.grey[600]);
}
