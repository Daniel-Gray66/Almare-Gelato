import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:almare_gelato/widgets/customer_drawer.dart';

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
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildFlavorCategory(
              context,
              'Traditional Flavors',
              {
                'Dark Chocolate': ['Cocoa', 'Sugar', 'Milk', 'Vanilla'],
                'Vanilla Beans': ['Vanilla', 'Milk', 'Sugar'],
                'Nocciola': ['Hazelnuts', 'Milk', 'Sugar'],
                'Stracciatella': ['Milk', 'Sugar', 'Chocolate Chips'],
                'Espresso': ['Coffee', 'Milk', 'Sugar'],
                'Pistachio': ['Pistachios', 'Milk', 'Sugar'],
                'Gianduja': ['Hazelnuts', 'Cocoa', 'Milk', 'Sugar'],
                'Tiramisu': ['Mascarpone', 'Coffee', 'Eggs', 'Sugar'],
                'Amarena': ['Cherries', 'Milk', 'Sugar'],
                'Malaga': ['Rum', 'Raisins', 'Milk', 'Sugar'],
                'Torrone': ['Nougat', 'Honey', 'Almonds', 'Sugar'],
                'Amaretto': ['Almonds', 'Milk', 'Sugar'],
                'Fior di Latte': ['Milk', 'Sugar', 'Cream'],
                'Bacio': ['Hazelnuts', 'Cocoa', 'Milk' , 'Sugar'],
              },
            ),
            const SizedBox(height: 20),
            _buildFlavorCategory(
              context,
              'Sorbet Flavors',
              {
                'Mango': ['Mango', 'Water', 'Sugar'],
                'Lemon': ['Lemon Juice', 'Water', 'Sugar'],
                'Raspberry': ['Raspberries', 'Water', 'Sugar'],
              },
            ),
            const SizedBox(height: 20),
            _buildFlavorCategory(
              context,
              'Almare Specials',
              {
                'Special Flavor 1': ['Ingredient A', 'Ingredient B'],
                'Special Flavor 2': ['Ingredient X', 'Ingredient Y'],
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlavorCategory(BuildContext context, String title, Map<String, List<String>> flavors) {
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
          children: flavors.keys.map((flavor) {
            return ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlavorDetailScreen(
                      flavorName: flavor,
                      ingredients: flavors[flavor]!,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
              ),
              child: Text(flavor),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class FlavorDetailScreen extends StatelessWidget {
  final String flavorName;
  final List<String> ingredients;

  const FlavorDetailScreen({
    super.key,
    required this.flavorName,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(flavorName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingredients for $flavorName:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...ingredients.map(
                  (ingredient) => Text(
                '- $ingredient',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
