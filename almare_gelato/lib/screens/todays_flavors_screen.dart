import 'package:flutter/material.dart';
import 'package:almare_gelato/widgets/customer_drawer.dart';

class TodaysFlavorsScreen extends StatelessWidget {
  const TodaysFlavorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Flavors"), // Add 'const' here
      ),
      drawer: const CustomDrawer(),
      body:  const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(label: Text('StrawBerry')), // Add 'const'
                Chip(label: Text('Lemon')),      // Add 'const'
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(label: Text('StrawBerry')), // Add 'const'
                Chip(label: Text('Lemon')),      // Add 'const'
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(label:  Text('StrawBerry')), // Add 'const'
                Chip(label:  Text('Lemon')),      // Add 'const'
              ],
            ),
            SizedBox(height: 30),
            Text(
              'For more flavors, check out our website!',
              style: TextStyle(fontSize: 16), // Add 'const'
            ),
          ],
        ),
      ),
    );
  }
}
