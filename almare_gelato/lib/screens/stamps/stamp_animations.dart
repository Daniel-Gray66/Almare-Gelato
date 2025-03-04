import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Creates and initializes animations for stamp effects
class StampAnimations {
  final TickerProvider vsync;
  late AnimationController controller;
  Animation<double>? pressAnimation;
  Animation<double>? scaleAnimation;
  Animation<double>? opacityAnimation;
  
  StampAnimations({required this.vsync}) {
    _initializeAnimations();
  }
  
  void _initializeAnimations() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: vsync,
    );

    pressAnimation = TweenSequence<double>([
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
    ]).animate(controller);

    scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 2.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutExpo)),
        weight: 100.0,
      ),
    ]).animate(controller);

    opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20.0,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 80.0,
      ),
    ]).animate(controller);
  }
  
  void dispose() {
    controller.dispose();
  }
  
  void playAnimation() {
    controller.reset();
    controller.forward();
  }
}

/// A widget that displays animated sparkles around a child widget
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

/// Data class for a single sparkle
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

/// A widget that displays an animated stamp with effects
class AnimatedStampIcon extends StatelessWidget {
  final int index;
  final int stampCount;
  final List<Color> stampColors;
  final int? lastAddedStampIndex;
  final AnimationController controller;
  final Animation<double>? pressAnimation;
  final Animation<double>? scaleAnimation;
  final Animation<double>? opacityAnimation;
  
  const AnimatedStampIcon({
    super.key,
    required this.index,
    required this.stampCount,
    required this.stampColors,
    required this.lastAddedStampIndex,
    required this.controller,
    required this.pressAnimation,
    required this.scaleAnimation,
    required this.opacityAnimation,
  });

  Color _getRandomColor() {
    final random = math.Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),  
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNewStamp = index == lastAddedStampIndex;
    final isStamped = index < stampCount;
    
    // Determine the stamp color
    Color stampColor;
    if (isStamped) {
      if (index < stampColors.length) {
        stampColor = stampColors[index];
      } else {
        stampColor = _getRandomColor();
      }
    } else {
      stampColor = Colors.grey;
    }
    
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (!isNewStamp || pressAnimation == null) {
          return _buildRegularStamp(isStamped, stampColor);
        }
        
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Shadow effect
            if (pressAnimation!.value < 1.0)
              Positioned(
                bottom: -2 * (1.0 - pressAnimation!.value),
                right: -2 * (1.0 - pressAnimation!.value),
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
              scale: pressAnimation!.value,
              child: Opacity(
                opacity: opacityAnimation?.value ?? 1.0,
                child: SparkleWidget(
                  showSparkle: isNewStamp && controller.value > 0.5,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.icecream,
                      size: 50,
                      color: stampColor,
                    ),
                  ),
                ),
              ),
            ),
            // Ink splatter effect
            if (controller.value > 0.2 && controller.value < 0.8)
              ...List.generate(8, (i) {
                final angle = (i * math.pi / 4);
                final progress = (controller.value - 0.2) * 1.7;
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
                        color: stampColor,
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

  Widget _buildRegularStamp(bool isStamped, Color color) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Icon(
        Icons.icecream,
        size: 50,
        color: isStamped ? color : Colors.grey,
      ),
    );
  }
} 