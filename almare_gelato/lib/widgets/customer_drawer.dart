import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/stamp_view_screen.dart';
import '../screens/flavor_view_screen.dart';
import '../screens/history_view_screen.dart';
import '../screens/announcements_screen.dart';
import 'package:almare_gelato/themes/themes_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ThemeColors.backgroundColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  ThemeColors.gradientStart,
                  ThemeColors.gradientEnd,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.shadowColor,
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'images/Logo.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Almare Gelato',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.icecream,
                  title: 'Stamp Card',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StampViewScreen()),
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.menu_book,
                  title: 'Flavors',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FlavorViewScreen()),
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.history,
                  title: 'History',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryViewScreen()),
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.campaign,
                  title: 'Announcements',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnnouncementsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: ThemeColors.accentColor,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ThemeColors.bodyTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}