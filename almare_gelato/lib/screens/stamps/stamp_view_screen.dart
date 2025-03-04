import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert';
import 'dart:math';
import '../../services/database_service.dart';
import '../../themes/themes_colors.dart';
import 'package:almare_gelato/navigation/customer_drawer.dart';
import 'stamp_animations.dart';

class StampViewScreen extends StatefulWidget {
  const StampViewScreen({super.key});

  @override
  State<StampViewScreen> createState() => _StampViewScreenState();
}

class _StampViewScreenState extends State<StampViewScreen> with SingleTickerProviderStateMixin {
  int _stamps = 0;
  List<Color> _stampColors = [];
  late StampAnimations _animations;
  int? _lastAddedStampIndex;
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _animations = StampAnimations(vsync: this);
    loadStamps();
  }

  @override
  void dispose() {
    _animations.dispose();
    super.dispose();
  }

  Color stringToColor(String colorString) {
    final values = colorString.split(',').map(int.parse).toList();
    return Color.fromARGB(255, values[0], values[1], values[2]);
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Column(
            children: [
              Icon(
                Icons.celebration,
                color: ThemeColors.primaryColor,
                size: 50,
              ),
              const SizedBox(height: 16),
              Text(
                'Congratulations!',
                style: TextStyle(
                  color: ThemeColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'You\'ve collected all 9 stamps! Show this to an employee on your next visit to receive a free kids gelato.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: ThemeColors.primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> loadStamps() async {
    try {
      final oldStampCount = _stamps;
      final stampData = await _databaseHelper.getStampData();
      final stamps = stampData['stamps'] as int? ?? 0;
      final colorsStr = stampData['colors'] as String? ?? '[]';

      List<Color> colors = [];
      if (colorsStr != '[]') {
        try {
          final colorsList = json.decode(colorsStr) as List;
          colors = colorsList.map((c) => stringToColor(c.toString())).toList();
        } catch (e) {
          print('Error parsing colors: $e');
        }
      }

      // Make sure we have enough colors for all stamps
      while (colors.length < stamps) {
        // Generate a random color for any missing stamps
        final random = Random();
        final color = Color.fromARGB(
          255,
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
        );
        colors.add(color);
      }

      setState(() {
        _stamps = stamps;
        _stampColors = colors;
        
        // If stamps increased, set the last added index
        if (stamps > oldStampCount) {
          _lastAddedStampIndex = stamps - 1;
          _animations.playAnimation();
          
          // Show completion dialog if we reached 9 stamps
          if (stamps == 9) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showCompletionDialog(context);
            });
          }
        }
      });
    } catch (e) {
      print('Error loading stamps: $e');
    }
  }

  Future<void> _scanQrCodeAndAddStamp() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (barcodeScanRes != '-1') {
        // Validate QR code here if needed
        
        // Generate a new color for the new stamp
        final random = Random();
        final newColor = Color.fromARGB(
          255,
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
        );
        
        // Add the new color to the existing colors
        List<String> colorsList = _stampColors.map((c) => '${c.red},${c.green},${c.blue}').toList();
        colorsList.add('${newColor.red},${newColor.green},${newColor.blue}');
        
        // Update the database with the new stamp and colors
        await _databaseHelper.updateStampData(_stamps + 1, json.encode(colorsList));
        
        // Reload stamps to update the UI
        await loadStamps();
      }
    } catch (e) {
      print('Error scanning QR code: $e');
    }
  }
  
  // Add this method to handle the test button
  Future<void> _addTestStamp() async {
    try {
      if (_stamps >= 9) {
        // Generate a new random color for the first stamp
        final random = Random();
        final newColor = Color.fromARGB(
          255,
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
        );
        final colorString = '${newColor.red},${newColor.green},${newColor.blue}';
        
        // Reset to 1 stamp with the new color
        print('Card reset after full stamp collection!');
        await _databaseHelper.resetStamps();  // This resets to 0
        
        // Important: The format should be a JSON array of strings, not a string with brackets
        await _databaseHelper.updateStampData(1, json.encode([colorString]));  // Properly encode as JSON
      } else {
        // Generate a new random color for the new stamp
        final random = Random();
        final newColor = Color.fromARGB(
          255,
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
        );
        final colorString = '${newColor.red},${newColor.green},${newColor.blue}';
        
        // Add the new color to the existing colors
        List<String> colorsList = _stampColors.map((c) => '${c.red},${c.green},${c.blue}').toList();
        colorsList.add(colorString);
        
        await _databaseHelper.updateStampData(_stamps + 1, json.encode(colorsList));
      }
      
      // Reload stamps to update the UI
      await loadStamps();
    } catch (e) {
      print('Error adding test stamp: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stamp Card',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Card title and description
              const Text(
                'Gelato Loyalty Card',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Collect 9 stamps to get a free kids gelato!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              
              // Stamp card with enhanced styling
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Stamp grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return AnimatedStampIcon(
                          index: index,
                          stampCount: _stamps,
                          stampColors: _stampColors,
                          lastAddedStampIndex: _lastAddedStampIndex,
                          controller: _animations.controller,
                          pressAnimation: _animations.pressAnimation,
                          scaleAnimation: _animations.scaleAnimation,
                          opacityAnimation: _animations.opacityAnimation,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Progress text
                    Text(
                      '$_stamps/9 stamps collected',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Buttons with enhanced styling
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _scanQrCodeAndAddStamp,
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Scan QR Code'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _addTestStamp,
                    icon: const Icon(Icons.add),
                    label: const Text('Test'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.accentColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}