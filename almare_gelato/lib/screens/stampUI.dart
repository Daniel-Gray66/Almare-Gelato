import 'package:flutter/material.dart';
import '../Database.dart';

class StampCardScreen extends StatefulWidget {
  @override
  _StampCardScreenState createState() => _StampCardScreenState();
}

class _StampCardScreenState extends State<StampCardScreen> {
  int stamps = 0;

  @override
  void initState() {
    super.initState();
    loadStamps();
  }

  Future<void> loadStamps() async {
    final currentStamps = await DatabaseHelper.instance.getStamps();
    setState(() {
      stamps = currentStamps;
    });
  }

  Future<void> addStamp() async {
    await DatabaseHelper.instance.addStamp();
    loadStamps(); // Refresh the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gelato Stamp Card')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Stamps Collected: $stamps', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: addStamp,
            child: Text('Add Stamp'),
          ),
        ],
      ),
    );
  }
}
