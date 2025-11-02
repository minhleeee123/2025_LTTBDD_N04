import 'package:flutter/material.dart';
import '../models/recipe.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
      ),
      body: ListView.builder(
        itemCount: sampleRecipes.length,
        itemBuilder: (context, index) {
          final recipe = sampleRecipes[index];
          return ListTile(
            title: Text(recipe.name),
            subtitle: Text(recipe.description),
          );
        },
      ),
    );
  }
}