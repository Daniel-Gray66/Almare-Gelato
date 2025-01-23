import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../Database.dart';

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
