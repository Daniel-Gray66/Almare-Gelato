import 'package:flutter/material.dart';
import 'package:almare_gelato/themes/themes_colors.dart';

class Common {
  static TableBorder border() {
    return TableBorder.all(
      color: ThemeColors.dividerColor,
      width: 1.5,
      borderRadius: BorderRadius.circular(8),
    );
  }

  static TableRow row(String day, String hours) {
    return TableRow(
      decoration: BoxDecoration(
        color: ThemeColors.surfaceColor,
        borderRadius: BorderRadius.circular(8),
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            day,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ThemeColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            hours,
            style: TextStyle(
              fontSize: 16,
              color: ThemeColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
