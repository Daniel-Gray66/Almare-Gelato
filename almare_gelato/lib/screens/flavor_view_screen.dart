import 'package:flutter/material.dart';
import 'home_screen.dart';

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
      color: Color(0xFFDCEDC8),
    ),
    FlavorInfo(
      name: 'Hazelnut',
      ingredients: ['Hazelnuts', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFFD7CCC8),
    ),
    FlavorInfo(
      name: 'Gulab Jamun',
      ingredients: ['Gulab Jamun', 'Pistachios', 'Milk', 'Cream', 'Sugar', 'Cardamom'],
      color: Color(0xFFFFB74D),  // Golden orange
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
      color: Color(0xFF8D6E63),  // Warm brown
    ),
  ];

  static const List<FlavorInfo> noNutFlavors = [
    FlavorInfo(
      name: 'Ube',
      ingredients: ['Purple Yam', 'Milk', 'Cream', 'Sugar', 'Vanilla'],
      color: Color(0xFF9575CD),  // Purple
    ),
    FlavorInfo(
      name: 'Key Lime',
      ingredients: ['Key Lime Juice', 'Milk', 'Cream', 'Sugar', 'Graham Cracker'],
      color: Color(0xFFDCEDC8),  // Light green
    ),
    FlavorInfo(
      name: 'Oreo Cookie',
      ingredients: ['Oreo Cookies', 'Milk', 'Cream', 'Sugar', 'Vanilla'],
      color: Color(0xFFEEEEEE),  // Light grey
    ),
    FlavorInfo(
      name: 'Cappuccino Chip',
      ingredients: ['Coffee', 'Chocolate Chips', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFFD7CCC8),  // Light brown
    ),
    FlavorInfo(
      name: 'Mint Chip',
      ingredients: ['Mint Extract', 'Chocolate Chips', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFFC8E6C9),  // Mint green
    ),
    FlavorInfo(
      name: 'Rose',
      ingredients: ['Rose Water', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFFF8BBD0),  // Light pink
    ),
    FlavorInfo(
      name: 'Dark Chocolate',
      ingredients: ['Dark Chocolate', 'Cocoa Powder', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF795548),  // Dark brown
    ),
    FlavorInfo(
      name: 'Salted Caramel',
      ingredients: ['Caramel', 'Sea Salt', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFFFFCC80),  // Caramel color
    ),
    FlavorInfo(
      name: 'Banana Caramel',
      ingredients: ['Fresh Bananas', 'Caramel', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFFFFE0B2),  // Light banana color
    ),
  ];

  static const List<FlavorInfo> sorbetFlavors = [
    FlavorInfo(
      name: 'Strawberry',
      ingredients: ['Fresh Strawberries', 'Water', 'Sugar', 'Lemon Juice'],
      color: Color(0xFFFFCDD2),  // Light strawberry pink
    ),
    FlavorInfo(
      name: 'Lemon',
      ingredients: ['Fresh Lemon Juice', 'Water', 'Sugar', 'Lemon Zest'],
      color: Color(0xFFFFF9C4),  // Light yellow
    ),
    FlavorInfo(
      name: 'Jamaica',
      ingredients: ['Hibiscus Flowers', 'Water', 'Sugar', 'Lime Juice'],
      color: Color(0xFFE57373),  // Deep red
    ),
    FlavorInfo(
      name: 'Jolly Rancher',
      ingredients: ['Jolly Rancher Syrup', 'Water', 'Sugar'],
      color: Color(0xFF81C784),  // Bright green
    ),
    FlavorInfo(
      name: 'Mango',
      ingredients: ['Fresh Mango', 'Water', 'Sugar', 'Lime Juice'],
      color: Color(0xFFFFB74D),  // Mango orange
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Flavors',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFF8BBD0),
        elevation: 0,
        centerTitle: true,  // Center the title
      ),
      backgroundColor: const Color(0xFFFCE4EC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCategorySection('Nut Flavors', nutFlavors),
              const SizedBox(height: 32),
              _buildCategorySection('Nut Free', noNutFlavors),
              const SizedBox(height: 32),
              _buildCategorySection('Sorbets', sorbetFlavors),
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
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFF8BBD0),
                const Color(0xFFF8BBD0).withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            title.toUpperCase(),  // Uppercase the title
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,  // Add letter spacing
              shadows: [
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),  // Increased spacing after title
        ...flavors.map((flavor) => _buildFlavorButton(flavor)),
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