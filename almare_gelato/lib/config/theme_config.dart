import 'package:flutter/material.dart';
import 'dart:math' as math;

class ThemeColors {
  // Primary colors - Professional palette with variety
  static const Color primaryColor = Color(0xFF3A506B); // Deep slate blue
  static const Color secondaryColor = Color(0xFF6B7A8F); // Muted blue-gray
  static const Color accentColor = Color(0xFFD7A270); // Warm gold
  static const Color tertiaryColor = Color(0xFF7C677F); // Muted purple
  
  // Gradient colors with more contrast
  static const List<Color> primaryGradient = [
    Color(0xFF2A3F5B), // Darker slate blue
    Color(0xFF5B7A9F), // Much lighter slate blue
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFFC68F55), // Darker gold
    Color(0xFFEDC9A1), // Much lighter gold
  ];
  
  static const List<Color> tertiaryGradient = [
    Color(0xFF6A5670), // Darker purple
    Color(0xFFAA9AAD), // Much lighter purple
  ];
  
  // Additional gradient options
  static const List<Color> blueGradient = [
    Color(0xFF2C5282), // Deep blue
    Color(0xFF63B3ED), // Light blue
  ];
  
  static const List<Color> greenGradient = [
    Color(0xFF276749), // Deep green
    Color(0xFF68D391), // Light green
  ];
  
  static const List<Color> redGradient = [
    Color(0xFFC53030), // Deep red
    Color(0xFFFCA5A5), // Light red
  ];
  
  static const List<Color> purpleGradient = [
    Color(0xFF6B46C1), // Deep purple
    Color(0xFFD6BCFA), // Light purple
  ];
  
  static const List<Color> orangeGradient = [
    Color(0xFFDD6B20), // Deep orange
    Color(0xFFFBD38D), // Light orange
  ];
  
  // Background colors
  static const Color backgroundColor = Color(0xFFF7F9FC); // Very light blue-gray
  static const Color cardColor = Colors.white;
  static const Color surfaceColor = Colors.white;
  
  // Text colors
  static const Color textPrimary = Color(0xFF1E2A3B); // Dark navy
  static const Color textSecondary = Color(0xFF546378); // Medium blue-gray
  static const Color textLight = Colors.white;
  
  // Status colors
  static const Color success = Color(0xFF4A8C7B); // Deep teal
  static const Color warning = Color(0xFFD4B483); // Muted gold
  static const Color error = Color(0xFFC15B58); // Muted red
  static const Color info = Color(0xFF5B7FA3); // Muted blue
  
  // Additional colors
  static const Color dividerColor = Color(0xFFE5E8ED);
  static const Color disabledColor = Color(0xFFEEF1F6);
  static const Color shadowColor = Color(0x1A000000); // 10% black shadow
  
  // Highlight colors for variety
  static const Color highlightBlue = Color(0xFF5B7FA3);
  static const Color highlightGreen = Color(0xFF4A8C7B);
  static const Color highlightRed = Color(0xFFC15B58);
  static const Color highlightYellow = Color(0xFFD4B483);
  static const Color highlightPurple = Color(0xFF7C677F);
}

class GradientUtils {
  static LinearGradient getPrimaryGradient({bool horizontal = true, double? angle}) {
    return _createGradient(ThemeColors.primaryGradient, horizontal, angle);
  }
  
  static LinearGradient getAccentGradient({bool horizontal = true, double? angle}) {
    return _createGradient(ThemeColors.accentGradient, horizontal, angle);
  }
  
  static LinearGradient getTertiaryGradient({bool horizontal = true, double? angle}) {
    return _createGradient(ThemeColors.tertiaryGradient, horizontal, angle);
  }
  
  static LinearGradient getBlueGradient({bool horizontal = true, double? angle}) {
    return _createGradient(ThemeColors.blueGradient, horizontal, angle);
  }
  
  static LinearGradient getGreenGradient({bool horizontal = true, double? angle}) {
    return _createGradient(ThemeColors.greenGradient, horizontal, angle);
  }
  
  static LinearGradient getRedGradient({bool horizontal = true, double? angle}) {
    return _createGradient(ThemeColors.redGradient, horizontal, angle);
  }
  
  static LinearGradient getPurpleGradient({bool horizontal = true, double? angle}) {
    return _createGradient(ThemeColors.purpleGradient, horizontal, angle);
  }
  
  static LinearGradient getOrangeGradient({bool horizontal = true, double? angle}) {
    return _createGradient(ThemeColors.orangeGradient, horizontal, angle);
  }
  
  static LinearGradient _createGradient(List<Color> colors, bool horizontal, double? angle) {
    if (angle != null) {
      // Convert angle to radians and calculate alignment
      final double radians = angle * (math.pi / 180);
      final double x = (math.cos(radians) + 1) / 2;
      final double y = (math.sin(radians) + 1) / 2;
      
      return LinearGradient(
        colors: colors,
        begin: Alignment(2 * x - 1, 2 * y - 1),
        end: Alignment(1 - 2 * x, 1 - 2 * y),
      );
    }
    
    return LinearGradient(
      colors: colors,
      begin: horizontal ? Alignment.centerLeft : Alignment.topCenter,
      end: horizontal ? Alignment.centerRight : Alignment.bottomCenter,
    );
  }
  
  // Create a custom gradient with specific colors
  static LinearGradient createCustomGradient(
    Color startColor,
    Color endColor, {
    bool horizontal = true,
    double? angle,
  }) {
    return _createGradient([startColor, endColor], horizontal, angle);
  }
  
  // Create a three-color gradient for more visual interest
  static LinearGradient createTriColorGradient(
    Color startColor,
    Color middleColor,
    Color endColor, {
    bool horizontal = true,
    double? angle,
  }) {
    return _createGradient([startColor, middleColor, endColor], horizontal, angle);
  }
}

class ThemeConfig {
  static ThemeData getTheme() {
    return ThemeData(
      primaryColor: ThemeColors.primaryColor,
      scaffoldBackgroundColor: ThemeColors.backgroundColor,
      cardColor: ThemeColors.cardColor,
      dividerColor: ThemeColors.dividerColor,
      disabledColor: ThemeColors.disabledColor,
      colorScheme: const ColorScheme.light(
        primary: ThemeColors.primaryColor,
        secondary: ThemeColors.secondaryColor,
        tertiary: ThemeColors.tertiaryColor,
        surface: ThemeColors.surfaceColor,
        background: ThemeColors.backgroundColor,
        error: ThemeColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        foregroundColor: ThemeColors.textLight,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
        ),
        headlineMedium: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.15,
        ),
        headlineSmall: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        bodyLarge: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 16,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 14,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          color: ThemeColors.textSecondary,
          fontSize: 12,
          letterSpacing: 0.4,
          height: 1.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.primaryColor,
          foregroundColor: ThemeColors.textLight,
          elevation: 1,
          shadowColor: ThemeColors.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.25,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ThemeColors.primaryColor,
          side: const BorderSide(color: ThemeColors.primaryColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.25,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ThemeColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.25,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: ThemeColors.cardColor,
        elevation: 1,
        shadowColor: ThemeColors.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ThemeColors.surfaceColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ThemeColors.dividerColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ThemeColors.dividerColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ThemeColors.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ThemeColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ThemeColors.error, width: 1.5),
        ),
        labelStyle: TextStyle(color: ThemeColors.textSecondary),
        hintStyle: TextStyle(color: ThemeColors.textSecondary.withOpacity(0.7)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ThemeColors.surfaceColor,
        selectedItemColor: ThemeColors.primaryColor,
        unselectedItemColor: ThemeColors.textSecondary,
        elevation: 4,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.textLight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ThemeColors.textPrimary,
        contentTextStyle: TextStyle(color: ThemeColors.textLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: ThemeColors.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        titleTextStyle: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: TextStyle(
          color: ThemeColors.textPrimary,
          fontSize: 16,
        ),
      ),
    );
  }
}
