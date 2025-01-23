import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../Database.dart';
import 'dart:math'; 

class StampViewScreen extends StatefulWidget {
  const StampViewScreen({super.key});

  @override
  State<StampViewScreen> createState() => _StampViewScreenState();
}

class _StampViewScreenState extends State<StampViewScreen> {
  int _stamps = 0; // Holds the current number of stamps

  @override
  void initState() {
    super.initState();
    loadStamps();
  }

  Future<void> loadStamps() async {
    final int stamps = await DatabaseHelper.instance.getStamps();
    setState(() {
      _stamps = stamps;
    });
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





Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
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
                      color: index < _stamps ? getRandomColor() : Colors.grey,
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