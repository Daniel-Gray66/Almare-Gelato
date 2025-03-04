import 'package:flutter/material.dart';

enum FlavorBase {
  cream,
  milk,
  water,
  coconut,
  almond
}

class Ingredient {
  final String name;
  final bool isAllergen;
  final String? allergenInfo;

  Ingredient({
    required this.name,
    this.isAllergen = false,
    this.allergenInfo,
  });
}

class Flavor {
  final String name;
  final FlavorBase base;
  final List<Ingredient> ingredients;
  final Color color;
  final bool isVegan;
  final bool isDairyFree;
  final bool isGlutenFree;
  final bool isNutFree;

  Flavor({
    required this.name,
    required this.base,
    required this.ingredients,
    required this.color,
    this.isVegan = false,
    this.isDairyFree = false,
    this.isGlutenFree = true,
    this.isNutFree = true,
  });

  List<Ingredient> getAllergens() {
    return ingredients.where((ingredient) => ingredient.isAllergen).toList();
  }

  bool containsAllergen(String allergenName) {
    return ingredients.any((ingredient) => 
      ingredient.isAllergen && 
      ingredient.name.toLowerCase().contains(allergenName.toLowerCase())
    );
  }
}
