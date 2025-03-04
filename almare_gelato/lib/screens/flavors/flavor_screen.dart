import 'package:flutter/material.dart';
import '../../widgets/navigation/customer_drawer.dart';
import '../../widgets/common/gradient_app_bar.dart';
import '../../config/theme_config.dart';

class FlavorScreen extends StatelessWidget {
  const FlavorScreen({super.key});

  // Categories and flavors with enhanced contrast
  final List<Map<String, dynamic>> _categories = const [
    {
      'name': 'NUT FLAVORS',
      'gradient': [Color(0xFF1A5D8F), Color(0xFF3A7CA5)], // Deeper blue gradient
      'flavors': [
        {
          'name': 'Pistachio',
          'color': Color(0xFF8BC34A), // More vibrant green
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Pistachio paste', 'Chopped pistachios'
          ],
          'allergens': ['Milk', 'Eggs', 'Tree nuts (pistachios)'],
        },
        {
          'name': 'Hazelnut',
          'color': Color(0xFFBB8E7A), // Richer brown
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Hazelnut paste', 'Chopped hazelnuts'
          ],
          'allergens': ['Milk', 'Eggs', 'Tree nuts (hazelnuts)'],
        },
        {
          'name': 'Gulab Jamun',
          'color': Color(0xFFFFA726), // Deeper orange
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Cardamom', 'Rose water', 'Saffron'
          ],
          'allergens': ['Milk', 'Eggs'],
        },
        {
          'name': 'Toasted Almond & Caramelized Fig',
          'color': Color(0xFFAA8877), // Richer tan
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Toasted almonds', 'Caramelized figs'
          ],
          'allergens': ['Milk', 'Eggs', 'Tree nuts (almonds)'],
        },
      ],
    },
    {
      'name': 'NUT FREE',
      'gradient': [Color(0xFF1A5D8F), Color(0xFF3A7CA5)], // Deeper blue gradient
      'flavors': [
        {
          'name': 'Ube',
          'color': Color(0xFFAB47BC), // Deeper purple
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Ube (purple yam) paste'
          ],
          'allergens': ['Milk', 'Eggs'],
        },
        {
          'name': 'Key Lime',
          'color': Color(0xFFC5E1A5), // Brighter lime green
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Key lime juice', 'Lime zest'
          ],
          'allergens': ['Milk', 'Eggs'],
        },
        {
          'name': 'Oreo Cookie',
          'color': Color(0xFF9E9E9E), // Darker gray
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Crushed Oreo cookies'
          ],
          'allergens': ['Milk', 'Eggs', 'Wheat', 'Soy'],
        },
      ],
    },
    {
      'name': 'FRUIT FLAVORS',
      'gradient': [Color(0xFF1A5D8F), Color(0xFF3A7CA5)], // Deeper blue gradient
      'flavors': [
        {
          'name': 'Strawberry',
          'color': Color(0xFFEF5350), // Brighter red
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Fresh strawberries', 'Strawberry puree'
          ],
          'allergens': ['Milk', 'Eggs'],
        },
        {
          'name': 'Mango',
          'color': Color(0xFFFFB300), // Richer yellow
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Mango puree', 'Fresh mango pieces'
          ],
          'allergens': ['Milk', 'Eggs'],
        },
      ],
    },
    {
      'name': 'CLASSICS',
      'gradient': [Color(0xFF1A5D8F), Color(0xFF3A7CA5)], // Deeper blue gradient
      'flavors': [
        {
          'name': 'Vanilla',
          'color': Color(0xFFFFF8E1), // Warmer cream color
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Vanilla extract', 'Vanilla beans'
          ],
          'allergens': ['Milk', 'Eggs'],
        },
        {
          'name': 'Chocolate',
          'color': Color(0xFF5D4037), // Richer chocolate brown
          'ingredients': [
            'Milk', 'Cream', 'Sugar', 'Egg yolks', 'Cocoa powder', 'Dark chocolate'
          ],
          'allergens': ['Milk', 'Eggs', 'May contain soy'],
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Our Flavors',
        showDrawerIcon: true,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: ThemeColors.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Instructions card at the top
          _buildInfoCard(
            icon: Icons.info_outline,
            title: 'Flavor Information',
            content: 'Tap on any flavor to see its main ingredients and allergen information.',
            color: ThemeColors.info,
          ),
          const SizedBox(height: 20),
          
          // Categories and flavors
          ..._categories.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCategoryHeader(category),
                const SizedBox(height: 8),
                ...category['flavors'].map<Widget>((flavor) => 
                  _buildFlavorItem(context, flavor)
                ).toList(),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
          
          // Note about rotating flavors at the bottom
          _buildInfoCard(
            icon: Icons.update,
            title: 'Rotating Selection',
            content: 'We regularly rotate our flavors to offer seasonal specialties and new creations. Visit us often to discover new favorites!',
            color: ThemeColors.accentColor,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color.withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(Map<String, dynamic> category) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: category['gradient'] ?? [ThemeColors.primaryColor, ThemeColors.primaryColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        category['name'],
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFlavorItem(BuildContext context, Map<String, dynamic> flavor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: flavor['color'],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _showIngredientsDialog(context, flavor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  flavor['name'],
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: _isLightColor(flavor['color']) 
                        ? Colors.black87 
                        : Colors.white,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: _isLightColor(flavor['color']) 
                      ? Colors.black54 
                      : Colors.white70,
                  size: 26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isLightColor(Color color) {
    // Calculate relative luminance
    final double luminance = color.computeLuminance();
    return luminance > 0.5;
  }

  void _showIngredientsDialog(BuildContext context, Map<String, dynamic> flavor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          flavor['name'],
          style: TextStyle(
            color: _isLightColor(flavor['color']) 
                ? ThemeColors.textPrimary 
                : flavor['color'],
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ingredients:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(
                flavor['ingredients'].length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Text(
                          flavor['ingredients'][index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Allergens:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(
                flavor['allergens'].length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: Colors.red, fontSize: 16)),
                      Expanded(
                        child: Text(
                          flavor['allergens'][index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}