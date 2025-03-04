import 'package:flutter/material.dart';
import 'dart:math' as math;

class SparkleWidget extends StatefulWidget {
  final Widget child;
  final int sparkleCount;
  final Duration duration;

  const SparkleWidget({
    Key? key,
    required this.child,
    this.sparkleCount = 20,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  State<SparkleWidget> createState() => _SparkleWidgetState();
}

class _SparkleWidgetState extends State<SparkleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Sparkle> _sparkles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _sparkles = List.generate(
      widget.sparkleCount,
      (_) => Sparkle(
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        size: math.Random().nextDouble() * 10 + 5,
        angle: math.Random().nextDouble() * 2 * math.pi,
        distance: math.Random().nextDouble() * 100 + 50,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            ..._sparkles.map((sparkle) {
              final progress = _controller.value;
              final scaledProgress = math.sin(progress * math.pi);
              
              return Positioned(
                left: math.cos(sparkle.angle) * sparkle.distance * scaledProgress,
                top: math.sin(sparkle.angle) * sparkle.distance * scaledProgress,
                child: Transform.rotate(
                  angle: progress * 2 * math.pi,
                  child: Opacity(
                    opacity: scaledProgress,
                    child: Container(
                      width: sparkle.size,
                      height: sparkle.size,
                      decoration: BoxDecoration(
                        color: sparkle.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            widget.child,
          ],
        );
      },
    );
  }
}

class Sparkle {
  final Color color;
  final double size;
  final double angle;
  final double distance;

  Sparkle({
    required this.color,
    required this.size,
    required this.angle,
    required this.distance,
  });
} 