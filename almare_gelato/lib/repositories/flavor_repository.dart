import 'package:flutter/material.dart';
import '../models/flavor_info.dart';

class FlavorRepository {
  static const List<FlavorInfo> nutFlavors = [
    FlavorInfo(
      name: 'Pistachio',
      ingredients: ['Pistachios', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF81C784),  // Soft green
    ),
    FlavorInfo(
      name: 'Hazelnut',
      ingredients: ['Hazelnuts', 'Milk', 'Cream', 'Sugar'],
      color: Color(0xFF90A4AE),  // Blue grey
    ),
    // ... other nut flavors
  ];

  static const List<FlavorInfo> noNutFlavors = [
    // ... copy from flavor_view_screen.dart
  ];

  static const List<FlavorInfo> sorbetFlavors = [
    // ... copy from flavor_view_screen.dart
  ];
} 