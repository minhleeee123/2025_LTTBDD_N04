import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/recipe.dart';
import '../models/app_state.dart';
import '../utils/translations.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'all';
  bool _isHeaderCollapsed = false;

  List<Recipe> get _filteredRecipes {
    return AppState.favoriteRecipes.where((recipe) {
      final matchesSearch = recipe.getName(AppState.language).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe.getDescription(AppState.language).toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesCategory = _selectedCategory == 'all' || recipe.category == _selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(
            appStrings[AppState.language]!['favorites_title']!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        actions: AppState.favoriteRecipes.isNotEmpty
            ? [
                IconButton(
                  icon: Icon(_isHeaderCollapsed ? Icons.expand_more : Icons.expand_less),
                  tooltip: _isHeaderCollapsed ? 'Hiện bộ lọc' : 'Ẩn bộ lọc',
                  onPressed: () {
                    setState(() {
                      _isHeaderCollapsed = !_isHeaderCollapsed;
                    });
                  },
                ),
              ]
            : null,
        ),
      ),
      body: AppState.favoriteRecipes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    appStrings[AppState.language]!['no_favorites']!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Collapsible Header Section
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _isHeaderCollapsed ? 0 : null,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isHeaderCollapsed ? 0 : 1,
                    child: Column(
                      children: [
                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: appStrings[AppState.language]!['search_placeholder'],
                                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                                prefixIcon: const Icon(Icons.search, size: 20),
                                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                            ),
                          ),
                        ),

                        // Category Filter
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              _buildCategoryChip('all', appStrings[AppState.language]!['category_all']!)
                                  .animate()
                                  .fadeIn(delay: 100.ms)
                                  .slideX(begin: -0.3, end: 0),
                              const SizedBox(width: 8),
                              _buildCategoryChip('main', appStrings[AppState.language]!['category_main']!)
                                  .animate()
                                  .fadeIn(delay: 200.ms)
                                  .slideX(begin: -0.3, end: 0),
                              const SizedBox(width: 8),
                              _buildCategoryChip('appetizer', appStrings[AppState.language]!['category_appetizer']!)
                                  .animate()
                                  .fadeIn(delay: 300.ms)
                                  .slideX(begin: -0.3, end: 0),
                              const SizedBox(width: 8),
                              _buildCategoryChip('snack', appStrings[AppState.language]!['category_snack']!)
                                  .animate()
                                  .fadeIn(delay: 400.ms)
                                  .slideX(begin: -0.3, end: 0),
                            ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Recipe List
                Expanded(
                  child: _filteredRecipes.isEmpty
                      ? Center(
                          child: Text(
                            appStrings[AppState.language]!['no_recipes']!,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
                            final crossAxisCount = isLandscape ? 2 : 1;
                            
                            return GridView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: isLandscape ? 1.1 : 1.4,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: _filteredRecipes.length,
                              itemBuilder: (context, index) {
                                return _buildRecipeCard(_filteredRecipes[index]);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildCategoryChip(String category, String label) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 0.8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  Color _getDifficultyBackgroundColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return const Color(0xFFE8F5E9); // Xanh lá nhạt
      case 'medium':
        return const Color(0xFFFFF9C4); // Vàng nhạt
      case 'hard':
        return const Color(0xFFFFEBEE); // Đỏ nhạt
      default:
        return Colors.grey.shade100;
    }
  }

  Color _getDifficultyBorderColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return const Color(0xFF66BB6A); // Xanh lá đậm
      case 'medium':
        return const Color(0xFFFFB300); // Vàng đậm
      case 'hard':
        return const Color(0xFFEF5350); // Đỏ đậm
      default:
        return Colors.grey.shade400;
    }
  }

  Color _getDifficultyTextColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return const Color(0xFF2E7D32); // Xanh lá đậm cho text
      case 'medium':
        return const Color(0xFFF57F17); // Vàng đậm cho text
      case 'hard':
        return const Color(0xFFC62828); // Đỏ đậm cho text
      default:
        return Colors.black;
    }
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        ).then((_) => setState(() {}));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    recipe.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.restaurant, size: 50),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: _getDifficultyBackgroundColor(recipe.difficulty),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _getDifficultyBorderColor(recipe.difficulty),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      recipe.difficulty == 'easy'
                          ? appStrings[AppState.language]!['difficulty_easy']!
                          : recipe.difficulty == 'medium'
                              ? appStrings[AppState.language]!['difficulty_medium']!
                              : appStrings[AppState.language]!['difficulty_hard']!,
                      style: TextStyle(
                        color: _getDifficultyTextColor(recipe.difficulty),
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        AppState.toggleFavorite(recipe);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.getName(AppState.language),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recipe.getDescription(AppState.language),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe.duration} ${appStrings[AppState.language]!['minutes']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.people, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe.servings} ${appStrings[AppState.language]!['servings']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Text(
                      recipe.category == 'main'
                          ? appStrings[AppState.language]!['category_main']!
                          : recipe.category == 'appetizer'
                              ? appStrings[AppState.language]!['category_appetizer']!
                              : appStrings[AppState.language]!['category_snack']!,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
