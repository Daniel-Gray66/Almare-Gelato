import 'package:flutter/material.dart';
import 'package:almare_gelato/widgets/customer_drawer.dart';
import '../Database.dart'; // Update with the correct path to your DatabaseHelper class

class StampViewScreen extends StatefulWidget {
  const StampViewScreen({super.key});

  @override
  State<StampViewScreen> createState() => _StampViewScreenState();
}

class _StampViewScreenState extends State<StampViewScreen> {
  int _stamps = 0; // Variable to store the number of stamps

  @override
  void initState() {
    super.initState();
    _loadStamps(); // Load stamps when the screen initializes
  }

  // Method to load the number of stamps from the database
  Future<void> _loadStamps() async {
    final stamps = await DatabaseHelper.instance.getStamps(); // Fetch stamps
    setState(() {
      _stamps = stamps; // Update the state with the fetched stamps
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stamp View'),
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Stamps:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(10, (index) {
                return Icon(
                  Icons.icecream,
                  size: 50,
                  color: index < _stamps ? Colors.orange : Colors.grey,
                );
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.instance.addStamp(); // Add a stamp to the database
                _loadStamps(); // Refresh the stamps
              },
              child: const Text('Add Stamp'),
            ),
          ],
        ),
      ),
    );
  }
}
