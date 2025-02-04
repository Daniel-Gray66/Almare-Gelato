import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:almare_gelato/themes/themes_colors.dart';
import '../widgets/customer_drawer.dart';

class FlavorInfo {
  final String name;
  final List<String> ingredients;
  final Color color;

  const FlavorInfo({
    required this.name,
    required this.ingredients,
    required this.color,
  });
}

class FlavorViewScreen extends StatelessWidget {
  const FlavorViewScreen({super.key});

  static const List<FlavorInfo> nutFlavors = [
    FlavorInfo(
      name: 'Pistachio',
      ingredients: ['Pistachios', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF81C784),  // Soft green
    ),
    FlavorInfo(
      name: 'Hazelnut',
      ingredients: ['Hazelnuts', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF90A4AE),  // Blue grey
    ),
    FlavorInfo(
      name: 'Gulab Jamun',
      ingredients: ['Gulab Jamun', 'Pistachios', 'Milk', 'Cream', 'Sugar', 'Cardamom'],
      color: Color(0xFF64B5F6),  // Light blue
    ),
    FlavorInfo(
      name: 'Toasted Almond & Caramelized Fig',
      ingredients: [
        'Toasted Almonds',
        'Caramelized Figs',
        'Honey',
        'Milk',
        'Cream',
        'Sugar',
      ],
      color: Color(0xFF90CAF9),  // Very light blue
    ),
  ];

  static const List<FlavorInfo> noNutFlavors = [
    FlavorInfo(
      name: 'Ube',
      ingredients: ['Purple Yam', 'Milk', 'Cream', 'Sugar', 'Vanilla'],
      color: Color(0xFF7986CB),  // Indigo
    ),
    FlavorInfo(
      name: 'Key Lime',
      ingredients: ['Key Lime Juice', 'Milk', 'Cream', 'Sugar', 'Graham Cracker'],
      color: Color(0xFF4FC3F7),  // Light blue
    ),
    FlavorInfo(
      name: 'Oreo Cookie',
      ingredients: ['Oreo Cookies', 'Milk', 'Cream', 'Sugar', 'Vanilla'],
      color: Color(0xFF78909C),  // Blue grey
    ),
    FlavorInfo(
      name: 'Cappuccino Chip',
      ingredients: ['Coffee', 'Chocolate Chips', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF90A4AE),  // Blue grey
    ),  
    FlavorInfo(
      name: 'Mint Chip',
      ingredients: ['Mint Extract', 'Chocolate Chips', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF4DB6AC),  // Teal
    ),
    FlavorInfo(
      name: 'Rose',
      ingredients: ['Rose Water', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF81D4FA),  // Light blue
    ),
    FlavorInfo(
      name: 'Dark Chocolate',
      ingredients: ['Dark Chocolate', 'Cocoa Powder', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF546E7A),  // Dark blue grey
    ),
    FlavorInfo(
      name: 'Salted Caramel',
      ingredients: ['Caramel', 'Sea Salt', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF64B5F6),  // Light blue
    ),
    FlavorInfo(
      name: 'Banana Caramel',
      ingredients: ['Fresh Bananas', 'Caramel', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF42A5F5),  // Blue
    ),
  ];

  static const List<FlavorInfo> sorbetFlavors = [
    FlavorInfo(
      name: 'Strawberry',
      ingredients: ['Fresh Strawberries', 'Water', 'Sugar', 'Lemon Juice'],
      color: Color(0xFF29B6F6),  // Light blue
    ),
    FlavorInfo(
      name: 'Lemon',
      ingredients: ['Fresh Lemon Juice', 'Water', 'Sugar', 'Lemon Zest'],
      color: Color(0xFF4FC3F7),  // Light blue
    ),
    FlavorInfo(
      name: 'Jamaica',
      ingredients: ['Hibiscus Flowers', 'Water', 'Sugar', 'Lime Juice'],
      color: Color(0xFF1E88E5),  // Blue
    ),
    FlavorInfo(
      name: 'Jolly Rancher',
      ingredients: ['Jolly Rancher Syrup', 'Water', 'Sugar'],
      color: Color(0xFF039BE5),  // Blue
    ),
    FlavorInfo(
      name: 'Mango',
      ingredients: ['Fresh Mango', 'Water', 'Sugar', 'Lime Juice'],
      color: Color(0xFF03A9F4),  // Light blue
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'Flavors',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: ThemeColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCategorySection('Nut Flavors', nutFlavors),
              const SizedBox(height: 24),
              _buildCategorySection('Nut Free', noNutFlavors),
              const SizedBox(height: 24),
              _buildCategorySection('Sorbets (Vegan)', sorbetFlavors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<FlavorInfo> flavors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                ThemeColors.primaryColor,
                ThemeColors.accentColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        ...flavors.map((flavor) => _buildFlavorButton(flavor)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildFlavorButton(FlavorInfo flavor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        title: Text(
          flavor.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: flavor.color,
        collapsedBackgroundColor: flavor.color.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ingredients:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...flavor.ingredients.map((ingredient) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8),
                      const SizedBox(width: 8),
                      Text(
                        ingredient,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}