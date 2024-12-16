import 'package:flutter/material.dart';
import '../widgets/customer_drawer.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelato Shop'),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text(
          'Welcome to Gelato Shop!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
