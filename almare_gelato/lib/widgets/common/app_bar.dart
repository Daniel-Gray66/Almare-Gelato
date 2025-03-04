import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showDrawerIcon;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.showDrawerIcon = true,
    this.bottom,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      backgroundColor: ThemeColors.primaryColor,
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
} 