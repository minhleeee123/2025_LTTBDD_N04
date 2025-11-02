import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/app_state.dart';
import '../utils/translations.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  String _getDifficultyText(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return appStrings[AppState.language]!['difficulty_easy']!;
      case 'medium':
        return appStrings[AppState.language]!['difficulty_medium']!;
      case 'hard':
        return appStrings[AppState.language]!['difficulty_hard']!;
      default:
        return difficulty;
    }
  }

  Color _getDifficultyBackgroundColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return const Color(0xFFE8F5E9); // Light green
      case 'medium':
        return const Color(0xFFFFF9C4); // Light yellow
      case 'hard':
        return const Color(0xFFFFEBEE); // Light red
      default:
        return Colors.grey.shade100;
    }
  }

  Color _getDifficultyBorderColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return const Color(0xFFA5D6A7); // Medium green
      case 'medium':
        return const Color(0xFFFFF59D); // Medium yellow
      case 'hard':
        return const Color(0xFFEF9A9A); // Medium red
      default:
        return Colors.grey.shade300;
    }
  }

  Color _getDifficultyTextColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return const Color(0xFF2E7D32); // Dark green
      case 'medium':
        return const Color(0xFFF57F17); // Dark yellow/orange
      case 'hard':
        return const Color(0xFFC62828); // Dark red
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = AppState.isFavorite(widget.recipe);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    AppState.toggleFavorite(widget.recipe);
                  });
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.recipe.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.restaurant, size: 80),
                  );
                },
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.recipe.getName(AppState.language),
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.recipe.getDescription(AppState.language),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Info Row
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.access_time,
                        '${widget.recipe.duration} ${appStrings[AppState.language]!['minutes']}',
                        null,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        Icons.people,
                        '${widget.recipe.servings} ${appStrings[AppState.language]!['servings']}',
                        null,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        Icons.signal_cellular_alt,
                        _getDifficultyText(widget.recipe.difficulty),
                        widget.recipe.difficulty,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Ingredients
                  _buildSectionTitle(appStrings[AppState.language]!['ingredients']!),
                  const SizedBox(height: 12),
                  ...widget.recipe.getIngredients(AppState.language).map((ingredient) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 30),

                  // Instructions
                  _buildSectionTitle(appStrings[AppState.language]!['instructions']!),
                  const SizedBox(height: 12),
                  ...widget.recipe.getSteps(AppState.language).asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${appStrings[AppState.language]!['step']} ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  step,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, String? difficulty) {
    final backgroundColor = difficulty != null
        ? _getDifficultyBackgroundColor(difficulty)
        : Colors.grey.shade100;
    final borderColor = difficulty != null
        ? _getDifficultyBorderColor(difficulty)
        : Colors.grey.shade300;
    final textColor = difficulty != null
        ? _getDifficultyTextColor(difficulty)
        : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 13, color: textColor),
          ),
        ],
      ),
    );
  }
}
