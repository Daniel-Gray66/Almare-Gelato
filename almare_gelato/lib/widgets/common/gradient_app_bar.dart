import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showDrawerIcon;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final List<Color>? gradientColors;
  final double? angle;

  const GradientAppBar({
    Key? key,
    required this.title,
    this.showDrawerIcon = true,
    this.bottom,
    this.actions,
    this.gradientColors,
    this.angle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default to a high-contrast gradient if none provided
    final colors = gradientColors ?? [
      const Color(0xFF1A2C42), // Very dark blue
      const Color(0xFF3A506B), // Medium blue
      const Color(0xFF5B7A9F), // Lighter blue
    ];
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: showDrawerIcon
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            : null,
        bottom: bottom,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
} 