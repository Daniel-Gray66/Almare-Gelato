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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildFlavorCategory(
              'Traditional Flavors',
              [
                'Dark Chocolate',
                'Vanilla Beans',
                'Nocciola',
                'Stracciatella',
                'Espresso',
                'Pistachio',
                'Gianduja',
                'Tiramisu',
                'Amarena',
                'Malaga',
                'Torrone',
                'Amaretto',
                'Fior di Latte',
                'Bacio',
              ],
            ),
            const SizedBox(height: 20),
            _buildFlavorCategory(
              'Sorbet Flavors',
              [
                'Mango',
                'Lemon',
                'Raspberry',
                // Add more flavors as needed
              ],
            ),
            const SizedBox(height: 20),
            _buildFlavorCategory(
              'Almare Specials',
              [
                'Flavor 1',
                'Flavor 2',
                'Flavor 3',
                // Add more flavors as needed
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlavorCategory(String title, List<String> flavors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: flavors
              .map(
                (flavor) => Chip(
              label: Text(flavor),
              backgroundColor: Colors.grey[200],
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
