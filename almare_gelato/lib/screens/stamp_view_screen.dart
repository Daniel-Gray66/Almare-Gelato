import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../Database.dart';
import 'dart:math'; 
import 'dart:convert';

class StampViewScreen extends StatefulWidget {
  const StampViewScreen({super.key});

  @override
  State<StampViewScreen> createState() => _StampViewScreenState();
}

class _StampViewScreenState extends State<StampViewScreen> {
  int _stamps = 0; // Holds the current number of stamps
  List<Color> _stampColors = [];

  @override
  void initState() {
    super.initState();
    loadStamps();
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),  
      random.nextInt(256),
    );
  }

  String colorToString(Color color) {
    return '${color.red},${color.green},${color.blue}';
  }

  Color stringToColor(String colorString){
    final values = colorString.split(',').map(int.parse).toList();
    return Color.fromARGB(255, values[0], values[1], values[2]);
  }

  Future<void> loadStamps() async {
    try {
      final stampData = await DatabaseHelper.instance.getStampData();
      final stamps = stampData['stamps'] as int? ?? 0;
      final colorsStr = stampData['colors'] as String? ?? '[]';

      List<Color> colors = [];
      if (colorsStr != '[]') {
        try {
          final colorsList = json.decode(colorsStr) as List;
          colors = colorsList.map((c) => stringToColor(c.toString())).toList();
        } catch (e) {
          print('Error parsing colors: $e');
          // If there's an error parsing colors, just use empty list
          colors = [];
        }
      }

      while (colors.length < stamps) {
        colors.add(getRandomColor());
      }

      await DatabaseHelper.instance.updateStampData(
        stamps, 
        json.encode(colors.map(colorToString).toList())
      );

      setState(() {
        _stamps = stamps;
        _stampColors = colors;  
      });
    } catch (e) {
      print('Error loading stamps: $e');
      // Handle error gracefully
      setState(() {
        _stamps = 0;
        _stampColors = [];
      });
    }
  }

  Future<void> _scanQrCodeAndAddStamp() async {
    try {
      final String qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (qrCode == 'ALMAREGELATOSTAMP123') {
        await DatabaseHelper.instance.addStamp();
        await loadStamps();
        print('Stamp added successfully!');
      } else if (qrCode != '-1') {
        print('Invalid QR code.');
      } else {
        print('QR code scanning cancelled.');
      }
    } catch (e) {
      print('Error scanning QR code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelato Stamp Card'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Stamps:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // 3x3 grid layout
            Column(
              children: List.generate(3, (row) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (col) {
                    int index = row * 3 + col;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.icecream,
                        size: 50,
                        color: index < _stamps ? _stampColors[index] : Colors.grey,
                      ),
                    );
                  }),
                );
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _scanQrCodeAndAddStamp, // Pass as a function reference
              child: const Text('Scan QR Code'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.instance.addStamp();
                await loadStamps();
              },
              child: const Text('Add Stamp (Test)'),
            ),
          ],
        ),
      ),
    );
  }
}