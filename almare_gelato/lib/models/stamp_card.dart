import 'dart:convert';
import 'package:flutter/material.dart';

class StampCard {
  final int totalStamps;
  final List<Stamp> stamps;
  static const int maxStamps = 9;

  StampCard({
    required this.totalStamps,
    required this.stamps,
  });

  // Factory constructor to create from database
  factory StampCard.fromMap(Map<String, dynamic> map) {
    final stampCount = map['stamps'] as int? ?? 0;
    final colorsString = map['colors'] as String? ?? '[]';
    List<dynamic> colorsList = json.decode(colorsString);
    
    List<Stamp> stamps = [];
    for (int i = 0; i < stampCount; i++) {
      if (i < colorsList.length) {
        final colorStr = colorsList[i].toString();
        final values = colorStr.split(',').map(int.parse).toList();
        stamps.add(Stamp(
          color: Color.fromARGB(255, values[0], values[1], values[2]),
          date: DateTime.now(), // You might want to store dates in the database
        ));
      }
    }

    return StampCard(
      totalStamps: stampCount,
      stamps: stamps,
    );
  }

  // Convert to map for database storage
  Map<String, dynamic> toMap() {
    return {
      'stamps': totalStamps,
      'colors': json.encode(stamps.map((s) => colorToString(s.color)).toList()),
    };
  }

  // Helper method to convert color to string
  static String colorToString(Color color) {
    return '${color.red},${color.green},${color.blue}';
  }

  // Check if card is full
  bool isFull() => totalStamps >= maxStamps;

  // Calculate progress
  double getProgress() => totalStamps / maxStamps;
}

class Stamp {
  final Color color;
  final DateTime date;

  Stamp({
    required this.color,
    required this.date,
  });
}