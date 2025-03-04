import 'package:flutter/material.dart';
import '../../config/theme_config.dart';
import '../../utils/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ThemeColors.backgroundColor,
        child: Column(
          children: [
            _buildHeader(),
            _buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Logo.jpg',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            const Text(
              AppConstants.appName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildMenuItem(
            context: context,
            icon: Icons.home,
            title: 'Home',
            route: '/',
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.icecream,
            title: 'Flavors',
            route: '/flavors',
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.notifications,
            title: 'Announcements',
            route: '/announcements',
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.card_membership,
            title: 'Stamp Card',
            route: '/stamp-card',
          ),
          const Divider(),
          _buildMenuItem(
            context: context,
            icon: Icons.location_on,
            title: 'Locations',
            route: '/locations',
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.info,
            title: 'About',
            route: '/about',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
  }) {
    final bool isCurrentRoute = ModalRoute.of(context)?.settings.name == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isCurrentRoute ? ThemeColors.primaryColor : ThemeColors.textColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isCurrentRoute ? ThemeColors.primaryColor : ThemeColors.textColor,
          fontWeight: isCurrentRoute ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        if (!isCurrentRoute) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      tileColor: isCurrentRoute ? ThemeColors.primaryColor.withOpacity(0.1) : null,
    );
  }
}