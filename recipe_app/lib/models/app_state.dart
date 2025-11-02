import 'recipe.dart';

class AppState {
  static String language = 'vi'; 
  static List<Recipe> favoriteRecipes = [];
  static List<Recipe> allRecipes = List.from(sampleRecipes);

  static bool isFavorite(Recipe recipe) {
    return favoriteRecipes.any((r) => r.id == recipe.id);
  }

  static void toggleFavorite(Recipe recipe) {
    if (isFavorite(recipe)) {
      favoriteRecipes.removeWhere((r) => r.id == recipe.id);
    } else {
      favoriteRecipes.add(recipe);
    }
  }

  static void addRecipe(Recipe recipe) {
    allRecipes.add(recipe);
  }
}
