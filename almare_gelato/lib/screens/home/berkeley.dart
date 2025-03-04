import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class BerkeleyScreen extends StatelessWidget {
  const BerkeleyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Your Berkeley screen content here
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Berkeley Location',
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
