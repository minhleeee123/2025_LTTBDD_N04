import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe.imageUrl),
            SizedBox(height: 16),
            Text(recipe.name, style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Text(recipe.description),
            SizedBox(height: 16),
            Text('Ingredients:', style: Theme.of(context).textTheme.titleLarge),
            ...recipe.ingredients.map((ingredient) => 
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text('• $ingredient'),
              ),
            ).toList(),
          ],
        ),
      ),
    );
  }
}