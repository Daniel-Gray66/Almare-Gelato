import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/stamp_view_screen.dart';
import '../screens/flavor_view_screen.dart';
import '../screens/todays_flavors_screen.dart';
import '../screens/history_view_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.icecream),
            title: const Text('Stamp View'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StampViewScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Flavor View'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FlavorViewScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_offer),
            title: const Text("Today's Flavors"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodaysFlavorsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History View'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryViewScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
