import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../Database.dart';
import 'dart:math'; 
import 'dart:convert';
import 'dart:math' as math;

class StampViewScreen extends StatefulWidget {
  const StampViewScreen({super.key});

  @override
  State<StampViewScreen> createState() => _StampViewScreenState();
}

class _StampViewScreenState extends State<StampViewScreen> with SingleTickerProviderStateMixin {
  int _stamps = 0; // Holds the current number of stamps
  List<Color> _stampColors = [];
  late AnimationController _controller;
  Animation<double>? _pressAnimation;  // Make nullable
  Animation<double>? _scaleAnimation;  // Make nullable
  Animation<double>? _opacityAnimation;  // Make nullable
  int? _lastAddedStampIndex;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();  // Separate initialization
    loadStamps();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pressAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.7)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.7, end: 1.2)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 30.0,
      ),
    ]).animate(_controller);

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 2.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutExpo)),
        weight: 100.0,
      ),
    ]).animate(_controller);

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20.0,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 80.0,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Column(
            children: [
              Icon(
                Icons.celebration,
                color: Colors.pink,
                size: 50,
              ),
              SizedBox(height: 16),
              Text(
                'Congratulations!',
                style: TextStyle(
                  color: Colors.pink,
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
              child: const Text('OK', style: TextStyle(color: Colors.pink)),
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
        if (stamps > oldStampCount) {
          _lastAddedStampIndex = stamps - 1;
          _controller.forward(from: 0.0).then((_) {
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                setState(() {
                  _lastAddedStampIndex = null;
                });
              }
            });
          });
          
          if (stamps == 9) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (mounted) {
                _showCompletionDialog(context);
              }
            });
          }
        }
      });
    } catch (e) {
      print('Error loading stamps: $e');
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

  Widget _buildStampIcon(int index) {
    final isNewStamp = index == _lastAddedStampIndex;
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (!isNewStamp || _pressAnimation == null) {
          return _buildRegularStamp(index);
        }
        
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Shadow effect
            if (_pressAnimation!.value < 1.0)
              Positioned(
                bottom: -2 * (1.0 - _pressAnimation!.value),
                right: -2 * (1.0 - _pressAnimation!.value),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.icecream,
                    size: 50,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            // Main stamp with press animation
            Transform.scale(
              scale: _pressAnimation!.value,
              child: Opacity(
                opacity: _opacityAnimation?.value ?? 1.0,
                child: SparkleWidget(
                  showSparkle: isNewStamp && _controller.value > 0.5,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.icecream,
                      size: 50,
                      color: _stampColors[index],
                    ),
                  ),
                ),
              ),
            ),
            // Ink splatter effect
            if (_controller.value > 0.2 && _controller.value < 0.8)
              ...List.generate(8, (i) {
                final angle = (i * math.pi / 4);
                final progress = (_controller.value - 0.2) * 1.7;
                final distance = math.sin(progress * math.pi) * 20;
                
                return Positioned(
                  left: math.cos(angle) * distance + 25,
                  top: math.sin(angle) * distance + 25,
                  child: Opacity(
                    opacity: (1 - progress).clamp(0.0, 1.0) * 0.4,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _stampColors[index],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),
          ],
        );
      },
    );
  }

  Widget _buildRegularStamp(int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Icon(
        Icons.icecream,
        size: 50,
        color: index < _stamps ? _stampColors[index] : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelato Stamp Card'),
        elevation: 0,
        backgroundColor: Colors.pink[100],
      ),
      backgroundColor: Colors.pink[50], // Light pink background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Stamp Card
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.pink[50]!,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo or Brand Image could go here
                        const Text(
                          'Almare Gelato',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Collect 9 stamps for a free gelato!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Stamps Grid
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.pink[100]!,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          width: 300,
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(3, (row) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(3, (col) {
                                  int index = row * 3 + col;
                                  return SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: Center(
                                      child: _buildStampIcon(index),
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '${_stamps}/9 stamps collected',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      backgroundColor: Colors.pink,
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
                    onPressed: () async {
                      await DatabaseHelper.instance.addStamp();
                      await loadStamps();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Test'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
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

class SparkleWidget extends StatefulWidget {
  final Widget child;
  final bool showSparkle;

  const SparkleWidget({
    super.key,
    required this.child,
    required this.showSparkle,
  });

  @override
  State<SparkleWidget> createState() => _SparkleWidgetState();
}

class _SparkleWidgetState extends State<SparkleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _sparkleController;
  List<Sparkle> sparkles = [];
  final int numberOfSparkles = 8;

  @override
  void initState() {
    super.initState();
    _sparkleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Create sparkles with random positions
    for (int i = 0; i < numberOfSparkles; i++) {
      sparkles.add(Sparkle(
        angle: (i * 2 * math.pi) / numberOfSparkles,
        distance: 30,
        size: math.Random().nextDouble() * 5 + 5,
      ));
    }
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SparkleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showSparkle && !oldWidget.showSparkle) {
      _sparkleController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        if (widget.showSparkle)
          ...sparkles.map((sparkle) {
            return AnimatedBuilder(
              animation: _sparkleController,
              builder: (context, child) {
                final progress = _sparkleController.value;
                final opacity = (1 - progress).clamp(0.0, 1.0);
                final distance = sparkle.distance * progress;
                
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(
                      distance * math.cos(sparkle.angle),
                      distance * math.sin(sparkle.angle),
                    ),
                  child: Opacity(
                    opacity: opacity,
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: sparkle.size,
                    ),
                  ),
                );
              },
            );
          }).toList(),
      ],
    );
  }
}

class Sparkle {
  final double angle;
  final double distance;
  final double size;

  Sparkle({
    required this.angle,
    required this.distance,
    required this.size,
  });
}