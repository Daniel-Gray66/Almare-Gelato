import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math' as math;
import '../../config/theme_config.dart';
import 'sparkle_effect.dart';

class StampCard extends StatelessWidget {
  final int stampCount;
  final List<Color> stampColors;
  final Function(int) onStampTap;
  final bool showSparkles;
  final int maxStamps = 9;

  const StampCard({
    Key? key,
    required this.stampCount,
    required this.stampColors,
    required this.onStampTap,
    this.showSparkles = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Stamp Card',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ThemeColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Collect 9 stamps for a free gelato!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            _buildStampGrid(),
            const SizedBox(height: 20),
            Text(
              'You have $stampCount ${stampCount == 1 ? 'stamp' : 'stamps'}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeColors.primaryColor,
              ),
            ),
            if (stampCount == maxStamps)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Congratulations! You\'ve earned a free gelato!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStampGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: maxStamps,
      itemBuilder: (context, index) {
        final hasStamp = index < stampCount;
        final stampColor = hasStamp && index < stampColors.length
            ? stampColors[index]
            : Colors.purple;

        return GestureDetector(
          onTap: () => onStampTap(index),
          child: hasStamp
              ? showSparkles && index == stampCount - 1
                  ? SparkleWidget(
                      child: _buildStamp(stampColor),
                    )
                  : _buildStamp(stampColor)
              : _buildEmptyStamp(),
        );
      },
    );
  }

  Widget _buildStamp(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.icecream,
          color: color,
          size: 64,
        ),
      ),
    );
  }

  Widget _buildEmptyStamp() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[400]!,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.icecream,
          color: Colors.grey[400],
          size: 64,
        ),
      ),
    );
  }
} 