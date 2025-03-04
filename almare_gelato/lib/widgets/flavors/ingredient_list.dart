import 'package:flutter/material.dart';
import '../../models/flavor.dart';

class IngredientList extends StatelessWidget {
  final List<Ingredient> ingredients;
  final bool highlightAllergens;

  const IngredientList({
    Key? key,
    required this.ingredients,
    this.highlightAllergens = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...ingredients.map((ingredient) => _buildIngredientItem(ingredient)),
      ],
    );
  }

  Widget _buildIngredientItem(Ingredient ingredient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: ingredient.name,
                    style: ingredient.isAllergen && highlightAllergens
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          )
                        : null,
                  ),
                  if (ingredient.isAllergen && ingredient.allergenInfo != null)
                    TextSpan(
                      text: ' (${ingredient.allergenInfo})',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 