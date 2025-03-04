import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import '../../config/theme_config.dart';
import '../../services/database_service.dart';
import '../../models/stamp_card.dart';

class StampScreen extends StatefulWidget {
  const StampScreen({super.key});

  @override
  State<StampScreen> createState() => _StampScreenState();
}

class _StampScreenState extends State<StampScreen> with SingleTickerProviderStateMixin {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  int _stampCount = 0;
  List<Color> _stampColors = [];
  bool _isLoading = true;
  late AnimationController _animationController;
  int? _lastAddedStampIndex;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadStampData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadStampData() async {
    try {
      final stampData = await _databaseHelper.getStampData();
      final stampCount = stampData['stamps'] as int;
      final colorsString = stampData['colors'] as String? ?? '[]';
      List<dynamic> colorsList = json.decode(colorsString);
      
      List<Color> colors = [];
      for (int i = 0; i < stampCount; i++) {
        if (i < colorsList.length) {
          final colorStr = colorsList[i].toString();
          final values = colorStr.split(',').map(int.parse).toList();
          colors.add(Color.fromARGB(255, values[0], values[1], values[2]));
        } else {
          // Fallback color if data is inconsistent
          colors.add(_getRandomColor());
        }
      }
      
      setState(() {
        _stampCount = stampCount;
        _stampColors = colors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  Color _getRandomColor() {
    // Generate vibrant colors for stamps
    final hue = _random.nextDouble() * 360;
    return HSLColor.fromAHSL(1.0, hue, 0.8, 0.6).toColor();
  }

  Future<void> _addStamp() async {
    try {
      if (_stampCount >= 9) {
        // Generate a new random color for the first stamp
        final newColor = _getRandomColor();
        final colorString = '${newColor.red},${newColor.green},${newColor.blue}';
        final colorsList = ['[$colorString]'];
        
        // Reset to 1 stamp with the new color
        print('Card reset after full stamp collection!');
        await _databaseHelper.resetStamps();  // This resets to 0
        await _databaseHelper.addStamp();     // This adds 1 stamp
        
        setState(() {
          _stampCount = 1;
          _stampColors = [newColor];
          _lastAddedStampIndex = 0;
        });
      } else {
        // Generate a new random color for the new stamp
        final newColor = _getRandomColor();
        final colorString = '${newColor.red},${newColor.green},${newColor.blue}';
        
        // Add the new color to the existing colors
        List<String> colorsList = _stampColors.map((c) => '${c.red},${c.green},${c.blue}').toList();
        colorsList.add(colorString);
        
        await _databaseHelper.updateStampData(_stampCount + 1, json.encode(colorsList));
        
        setState(() {
          _stampCount++;
          _stampColors.add(newColor);
          _lastAddedStampIndex = _stampCount - 1;
        });
      }
      _animationController.reset();
      _animationController.forward();
    } catch (e) {
      print('Error adding stamp: $e');
      // Handle error
    }
  }

  void _showMenu() {
    // Show a simple drawer or menu instead of navigating
    Scaffold.of(context).openDrawer();
    // If there's no drawer, you can show a simple dialog instead
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Menu'),
          content: const Text('Menu options would appear here'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loyalty Program'),
        backgroundColor: const Color(0xFF263238), // Dark blue-gray color from screenshot
        centerTitle: false, // Align title to the left as in screenshot
        elevation: 0,
        // Fixed menu button to not cause black screen
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Navigate to home screen instead of popping
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        actions: [
          // Add test button in app bar for convenience
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addStamp,
            tooltip: 'Add test stamp',
          ),
        ],
      ),
      backgroundColor: Colors.grey[100], // Light gray background from screenshot
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main card - DIRECTLY SHOWN HERE
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          const Text(
                            'Almare Gelato',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Collect 9 stamps for a free gelato!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Stamp grid in a container with border - NOW WITH CIRCLES
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: 9,
                              itemBuilder: (context, index) {
                                final isStamped = index < _stampCount;
                                
                                // Use specific colors from the screenshot for the first 3 stamps
                                Color stampColor;
                                if (isStamped) {
                                  if (index == 0) stampColor = const Color(0xFFBEE15B); // Lime green
                                  else if (index == 1) stampColor = const Color(0xFFAA52E4); // Purple
                                  else if (index == 2) stampColor = const Color(0xFFFF8A65); // Orange
                                  else stampColor = _stampColors.length > index ? _stampColors[index] : _getRandomColor();
                                } else {
                                  stampColor = Colors.grey.shade200;
                                }
                                
                                return Container(
                                  decoration: BoxDecoration(
                                    color: stampColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: isStamped
                                        ? const Icon(
                                            Icons.icecream,
                                            color: Colors.white,
                                            size: 32,
                                          )
                                        : Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Stamp count
                          Text(
                            '$_stampCount/9 stamps collected',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Bottom buttons - Styled like in the screenshot
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.qr_code_scanner, size: 20),
                            label: const Text('Scan QR Code'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF37474F), // Dark blue-gray
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: _addStamp,
                          icon: const Icon(Icons.add, size: 20),
                          label: const Text('Test'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF37474F), // Dark blue-gray
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // How It Works section - Styled like in the screenshot
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Color(0xFF3F51B5), // Indigo
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'How It Works',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Collect stamps with every purchase of a gelato. Once you collect 9 stamps, you can redeem them for a free gelato of your choice!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}