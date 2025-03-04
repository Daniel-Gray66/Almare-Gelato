import 'package:flutter/material.dart';
import '../../config/theme_config.dart';
import '../../widgets/navigation/customer_drawer.dart';
import '../../models/announcement.dart';
import '../../repositories/announcement_repository.dart';
import '../../widgets/common/app_bar.dart';
import 'dart:math' as math;

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'Announcements'),
      drawer: const CustomDrawer(),
      backgroundColor: ThemeColors.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAnnouncement(
            title: 'Summer Flavors Now Available!',
            date: 'June 1, 2023',
            content: 'Beat the heat with our new summer flavors! Try our refreshing Watermelon Sorbet, Coconut Lime, and Passion Fruit gelato.',
            imagePath: 'assets/images/summer_flavors.jpg',
            isNew: true,
          ),
          _buildAnnouncement(
            title: 'Holiday Hours',
            date: 'May 20, 2023',
            content: 'We will be open with special extended hours during the Memorial Day weekend: Saturday and Sunday 11am-10pm, Monday 12pm-8pm.',
          ),
          _buildAnnouncement(
            title: 'New Loyalty Program',
            date: 'May 5, 2023',
            content: 'We\'re excited to announce our new digital loyalty program! Collect stamps with each purchase and earn free gelato. Download our app to get started.',
            imagePath: 'assets/images/loyalty.jpg',
          ),
          _buildAnnouncement(
            title: 'Catering Services',
            date: 'April 15, 2023',
            content: 'Planning a special event? We offer catering services for weddings, corporate events, and parties. Contact us for more information.',
          ),
          _buildAnnouncement(
            title: 'Vegan Options Expanded',
            date: 'March 10, 2023',
            content: 'We\'ve expanded our selection of vegan gelato and sorbet options! Now offering at least 5 vegan choices daily.',
            imagePath: 'assets/images/vegan.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncement({
    required String title,
    required String date,
    required String content,
    String? imagePath,
    bool isNew = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePath != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 180,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isNew)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: ThemeColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}