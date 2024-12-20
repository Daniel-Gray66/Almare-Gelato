import 'package:flutter/material.dart';
import 'home_screen.dart';

class StampViewScreen extends StatelessWidget {
  const StampViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stamp View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text('This is the Stamp View screen.'),
      ),
    );
  }
}
