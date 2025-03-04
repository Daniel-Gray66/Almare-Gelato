import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color>? gradientColors;
  final IconData? icon;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double? angle;

  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.gradientColors,
    this.icon,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    this.elevation = 1.0,
    this.angle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? ThemeColors.primaryGradient;
    
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: ThemeColors.textLight),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: const TextStyle(
                  color: ThemeColors.textLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 