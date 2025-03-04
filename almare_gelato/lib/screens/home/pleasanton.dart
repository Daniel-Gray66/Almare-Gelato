import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class PleasantonScreen extends StatelessWidget {
  const PleasantonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Your Pleasanton screen content here
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Pleasanton Location',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Add more widgets as needed
        ],
      ),
    );
  }
}