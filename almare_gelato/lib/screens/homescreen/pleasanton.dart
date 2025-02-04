import 'package:flutter/material.dart';
import 'common.dart';
import 'package:almare_gelato/themes/themes_colors.dart';

class Pleasanton extends StatelessWidget {
  const Pleasanton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [storefrontImage(context), hours()],
    );
  }

  Widget storefrontImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            boxShadow: [
              BoxShadow(
                color: ThemeColors.shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35.0),
            child: Image.asset(
              'images/pleasanton.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget hours() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ThemeColors.surfaceColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: ThemeColors.dividerColor,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.shadowColor,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Hours",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.primaryColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Table(
                    border: Common.border(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      Common.row("Mon", "Closed"),
                      Common.row("T-Th", "1pm-8pm"),
                      Common.row("Fri", "12pm-8pm"),
                      Common.row("Sat", "12pm-9pm"),
                      Common.row("Sun", "Closed"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildInfoSection(
              "Contact",
              [
                InfoItem(Icons.phone, "925 425 7266"),
              ],
            ),
            const SizedBox(height: 32),
            _buildInfoSection(
              "Delivery Partners",
              [
                InfoItem(Icons.delivery_dining, "UberEats"),
                InfoItem(Icons.delivery_dining, "Grubhub"),
                InfoItem(Icons.delivery_dining, "Doordash"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<InfoItem> items) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeColors.surfaceColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ThemeColors.dividerColor,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ThemeColors.primaryColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: ThemeColors.accentColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  item.text,
                  style: TextStyle(
                    fontSize: 18,
                    color: ThemeColors.textColor,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}

class InfoItem {
  final IconData icon;
  final String text;

  InfoItem(this.icon, this.text);
}