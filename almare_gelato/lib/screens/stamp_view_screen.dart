import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:almare_gelato/widgets/customer_drawer.dart';

class StampViewScreen extends StatelessWidget {
  const StampViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stamp View'),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('This is the Stamp View screen.'),
      ),
    );
  }
}
