import 'package:flutter/material.dart';
import 'home_screen.dart';

class FlavorViewScreen extends StatelessWidget {
  const FlavorViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flavor View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          )
        ],
      ),
      body: const Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Traditional Flavors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('...'),
            SizedBox(height: 20),
            Text(
              'Sorbet Flavors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('...'),
            SizedBox(height: 20),
            Text(
              'Almare Specials',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('...'),
          ],
        ),
      ),
    );
  }
}
