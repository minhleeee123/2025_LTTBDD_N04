class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int duration;
  final int servings;
  final String difficulty; 
  final String category;   
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.servings,
    required this.difficulty,
    required this.category,
    required this.ingredients,
  });
}

// Test data - chỉ 1 recipe
final List<Recipe> sampleRecipes = [
  Recipe(
    id: '1',
    name: 'Phở Việt Nam',
    description: 'Món phở bò truyền thống',
    imageUrl: 'https://images.unsplash.com/photo-1626804475297-41608ea09aeb?w=800',
    duration: 120,
    servings: 4,
    difficulty: 'de',
    category: 'mon chinh',
    ingredients: [
      '500g thịt bò',
      '200g bánh phở',
      '2 củ hành tây',
      'Gừng, hành lá',
      'Rau thơm (ngò gai, húng quế)',
      'Gia vị: muối, đường, nước mắm',
    ],
  ),
];