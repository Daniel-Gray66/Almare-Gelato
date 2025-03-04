import 'package:flutter/material.dart';
import '../../widgets/common/app_bar.dart';
import '../../config/theme_config.dart';

class AllergenInfoScreen extends StatelessWidget {
  const AllergenInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Allergen Information',
        showDrawerIcon: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      backgroundColor: ThemeColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              title: 'Common Allergens in Gelato',
              content: 'Our gelato may contain the following allergens:',
              items: [
                'Milk and dairy products',
                'Eggs',
                'Nuts (various types including peanuts, almonds, hazelnuts)',
                'Soy',
                'Wheat (in some flavors with cookies or cake pieces)',
                'Gluten (in some flavors with cookies, cake, or cone pieces)',
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Cross-Contamination Notice',
              content: 'All of our gelato is made in the same facility and with shared equipment. While we take precautions to clean thoroughly between batches, cross-contamination with allergens is possible.',
              isWarning: true,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Dietary Options',
              content: 'We offer several options for various dietary needs:',
              items: [
                'Dairy-free sorbets (fruit-based)',
                'Vegan options (clearly marked)',
                'No sugar added options (available for select flavors)',
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Ask Our Staff',
              content: 'Our staff is knowledgeable about ingredients in our current flavors. Please ask if you have specific concerns about allergens or dietary restrictions.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    List<String>? items,
    bool isWarning = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isWarning
            ? const BorderSide(color: Colors.red, width: 1)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isWarning ? Colors.red : ThemeColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
            if (items != null) ...[
              const SizedBox(height: 8),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(child: Text(item)),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
} 