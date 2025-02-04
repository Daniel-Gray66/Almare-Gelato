import 'package:flutter/material.dart';

class ThemeColors {
  // Soft Modern scheme
  static const primaryColor = Color(0xFF4A5568);    // Slate gray
  static const accentColor = Color(0xFF718096);     // Cool gray
  static const backgroundColor = Color(0xFFFAFAFA); // Off white
  static const surfaceColor = Colors.white;
  static const textColor = Color(0xFF2D3748);       // Dark slate

  // Additional colors
  static const cardColor = Colors.white;
  static const shadowColor = Color(0x1A000000);     
  static const dividerColor = Color(0xFFE2E8F0);    // Light gray

  // Gradients
  static const gradientStart = Color(0xFF4A5568);   // Slate gray
  static const gradientEnd = Color(0xFF718096);     // Cool gray
  
  // Text colors
  static const titleTextColor = Colors.white;
  static const bodyTextColor = Color(0xFF2D3748);   // Dark slate
  static const subtitleTextColor = Color(0xFF718096); // Cool gray

  // Status colors
  static const successColor = Color(0xFF68D391);    // Green
  static const warningColor = Color(0xFFF6E05E);    // Yellow
  static const errorColor = Color(0xFFFC8181);      // Red
  
  // Button colors
  static const buttonPrimaryColor = gradientStart;
  static const buttonSecondaryColor = accentColor;
}
