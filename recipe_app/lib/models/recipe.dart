class Recipe {
  final String id;
  final String nameVi;
  final String nameEn;
  final String descriptionVi;
  final String descriptionEn;
  final String imageUrl;
  final int duration; // minutes
  final int servings;
  final String difficulty; // 'easy', 'medium', 'hard'
  final String category; // 'main', 'appetizer', 'snack'
  final List<String> ingredientsVi;
  final List<String> ingredientsEn;
  final List<String> stepsVi;
  final List<String> stepsEn;

  Recipe({
    required this.id,
    required this.nameVi,
    required this.nameEn,
    required this.descriptionVi,
    required this.descriptionEn,
    required this.imageUrl,
    required this.duration,
    required this.servings,
    required this.difficulty,
    required this.category,
    required this.ingredientsVi,
    required this.ingredientsEn,
    required this.stepsVi,
    required this.stepsEn,
  });

  String getName(String language) {
    return language == 'vi' ? nameVi : nameEn;
  }

  String getDescription(String language) {
    return language == 'vi' ? descriptionVi : descriptionEn;
  }

  List<String> getIngredients(String language) {
    return language == 'vi' ? ingredientsVi : ingredientsEn;
  }

  List<String> getSteps(String language) {
    return language == 'vi' ? stepsVi : stepsEn;
  }
}

// Sample data
final List<Recipe> sampleRecipes = [
  Recipe(
    id: '1',
    nameVi: 'Phở Việt Nam',
    nameEn: 'Vietnamese Pho',
    descriptionVi: 'Món phở bò truyền thống với nước dùng thơm ngon',
    descriptionEn: 'Traditional beef pho with delicious broth',
    imageUrl: 'https://images.unsplash.com/photo-1626804475297-41608ea09aeb?w=800',
    duration: 120,
    servings: 4,
    difficulty: 'medium',
    category: 'main',
    ingredientsVi: [
      '500g thịt bò',
      '200g bánh phở',
      '2 củ hành tây',
      'Gừng, hành lá',
      'Rau thơm (ngò gai, húng quế)',
      'Gia vị: muối, đường, nước mắm',
    ],
    ingredientsEn: [
      '500g beef',
      '200g rice noodles',
      '2 onions',
      'Ginger, scallions',
      'Herbs (cilantro, basil)',
      'Seasonings: salt, sugar, fish sauce',
    ],
    stepsVi: [
      'Ninh xương bò với hành, gừng trong 3 tiếng',
      'Luộc thịt bò và thái lát mỏng',
      'Chần bánh phở trong nước sôi',
      'Cho bánh phở vào tô, thêm thịt bò',
      'Chan nước dùng nóng lên trên',
      'Thêm rau thơm và gia vị vào',
    ],
    stepsEn: [
      'Simmer beef bones with onion and ginger for 3 hours',
      'Boil beef and slice thinly',
      'Blanch rice noodles in boiling water',
      'Place noodles in bowl, add beef',
      'Pour hot broth over',
      'Add herbs and seasonings',
    ],
  ),
  Recipe(
    id: '2',
    nameVi: 'Gỏi Cuốn',
    nameEn: 'Fresh Spring Rolls',
    descriptionVi: 'Món gỏi cuốn tươi mát với tôm và rau sống',
    descriptionEn: 'Fresh spring rolls with shrimp and vegetables',
    imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800',
    duration: 30,
    servings: 4,
    difficulty: 'easy',
    category: 'appetizer',
    ingredientsVi: [
      '12 tờ bánh tráng',
      '200g tôm',
      '100g thịt ba chỉ',
      'Bún tươi',
      'Rau sống (xà lách, húng quế)',
      'Tương đen, tương ớt',
    ],
    ingredientsEn: [
      '12 rice paper sheets',
      '200g shrimp',
      '100g pork belly',
      'Fresh vermicelli',
      'Fresh vegetables (lettuce, basil)',
      'Hoisin sauce, chili sauce',
    ],
    stepsVi: [
      'Luộc tôm và thịt ba chỉ',
      'Thái tôm làm đôi, thịt thái lát mỏng',
      'Nhúng bánh tráng vào nước ấm',
      'Đặt rau, bún, tôm, thịt lên bánh tráng',
      'Cuốn chặt và chấm tương',
    ],
    stepsEn: [
      'Boil shrimp and pork belly',
      'Cut shrimp in half, slice pork thinly',
      'Dip rice paper in warm water',
      'Place vegetables, vermicelli, shrimp, pork on rice paper',
      'Roll tightly and dip in sauce',
    ],
  ),
  Recipe(
    id: '3',
    nameVi: 'Bánh Mì Việt Nam',
    nameEn: 'Vietnamese Baguette',
    descriptionVi: 'Bánh mì giòn tan với nhân thịt và rau thơm',
    descriptionEn: 'Crispy baguette with meat and herbs',
    imageUrl: 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=800',
    duration: 20,
    servings: 2,
    difficulty: 'easy',
    category: 'snack',
    ingredientsVi: [
      '2 ổ bánh mì',
      '100g pate',
      '100g jambon/chả lụa',
      'Dưa chua, cà rốt muối',
      'Rau mùi, húng quế',
      'Ớt, nước tương',
    ],
    ingredientsEn: [
      '2 baguettes',
      '100g pate',
      '100g ham/Vietnamese ham',
      'Pickled radish, pickled carrot',
      'Cilantro, basil',
      'Chili, soy sauce',
    ],
    stepsVi: [
      'Nướng bánh mì cho giòn',
      'Xẻ dọc bánh mì',
      'Phết pate lên bánh',
      'Cho jambon/chả lụa vào',
      'Thêm dưa chua, rau thơm',
      'Thêm ớt và nước tương',
    ],
    stepsEn: [
      'Toast baguette until crispy',
      'Cut baguette lengthwise',
      'Spread pate on bread',
      'Add ham/Vietnamese ham',
      'Add pickled vegetables and herbs',
      'Add chili and soy sauce',
    ],
  ),
  Recipe(
    id: '4',
    nameVi: 'Cơm Chiên Dương Châu',
    nameEn: 'Yangzhou Fried Rice',
    descriptionVi: 'Cơm chiên thập cẩm với tôm, xúc xích và rau củ',
    descriptionEn: 'Mixed fried rice with shrimp, sausage and vegetables',
    imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800',
    duration: 25,
    servings: 3,
    difficulty: 'easy',
    category: 'main',
    ingredientsVi: [
      '3 chén cơm nguội',
      '150g tôm',
      '100g xúc xích',
      '2 quả trứng',
      'Đậu Hà Lan, cà rốt',
      'Hành tây, tỏi',
      'Gia vị: dầu hào, nước tương',
    ],
    ingredientsEn: [
      '3 cups cold rice',
      '150g shrimp',
      '100g sausage',
      '2 eggs',
      'Green peas, carrots',
      'Onion, garlic',
      'Seasonings: oyster sauce, soy sauce',
    ],
    stepsVi: [
      'Đánh trứng và làm trứng bác',
      'Xào tỏi, hành tây thơm',
      'Cho tôm, xúc xích vào xào',
      'Thêm rau củ xào chín',
      'Cho cơm vào đảo đều',
      'Nêm gia vị và trứng bác',
    ],
    stepsEn: [
      'Beat eggs and make scrambled eggs',
      'Stir-fry garlic and onion',
      'Add shrimp and sausage, stir-fry',
      'Add vegetables and cook',
      'Add rice and mix well',
      'Season and add scrambled eggs',
    ],
  ),
  Recipe(
    id: '5',
    nameVi: 'Bún Chả Hà Nội',
    nameEn: 'Hanoi Grilled Pork with Noodles',
    descriptionVi: 'Thịt nướng thơm lừng ăn kèm bún và nước mắm chua ngọt',
    descriptionEn: 'Fragrant grilled pork with noodles and sweet-sour dipping sauce',
    imageUrl: 'https://images.unsplash.com/photo-1569562211093-4ed0d0758f12?w=800',
    duration: 45,
    servings: 4,
    difficulty: 'medium',
    category: 'main',
    ingredientsVi: [
      '500g thịt ba chỉ',
      '300g bún tươi',
      '3 muỗng đường',
      'Nước mắm, giấm',
      'Tỏi, ớt',
      'Rau sống (xà lách, rau thơm)',
    ],
    ingredientsEn: [
      '500g pork belly',
      '300g fresh vermicelli',
      '3 spoons sugar',
      'Fish sauce, vinegar',
      'Garlic, chili',
      'Fresh vegetables (lettuce, herbs)',
    ],
    stepsVi: [
      'Ướp thịt với nước mắm, đường, tiêu',
      'Nướng thịt trên than hoa',
      'Pha nước mắm chua ngọt',
      'Chần bún sơ qua',
      'Bày rau sống ra đĩa',
      'Ăn kèm với bún và rau',
    ],
    stepsEn: [
      'Marinate pork with fish sauce, sugar, pepper',
      'Grill pork on charcoal',
      'Mix sweet-sour dipping sauce',
      'Blanch vermicelli briefly',
      'Arrange fresh vegetables on plate',
      'Serve with noodles and vegetables',
    ],
  ),
  Recipe(
    id: '6',
    nameVi: 'Chả Giò',
    nameEn: 'Vietnamese Fried Spring Rolls',
    descriptionVi: 'Chả giò giòn rụm với nhân thịt và rau củ',
    descriptionEn: 'Crispy fried spring rolls with meat and vegetables',
    imageUrl: 'https://images.unsplash.com/photo-1552332386-f8dd00dc2f85?w=800',
    duration: 40,
    servings: 20,
    difficulty: 'medium',
    category: 'appetizer',
    ingredientsVi: [
      '20 tờ bánh đa nem',
      '300g thịt lợn xay',
      '100g tôm băm',
      'Miến, nấm mèo',
      'Cà rốt, củ sắn',
      'Trứng, gia vị',
    ],
    ingredientsEn: [
      '20 spring roll wrappers',
      '300g ground pork',
      '100g minced shrimp',
      'Glass noodles, wood ear mushrooms',
      'Carrot, jicama',
      'Eggs, seasonings',
    ],
    stepsVi: [
      'Trộn đều nhân với gia vị',
      'Bọc nhân vào bánh đa nem',
      'Quét lòng đỏ trứng để dính',
      'Chiên vàng giòn trong dầu nóng',
      'Vớt ra để ráo dầu',
      'Ăn kèm với rau sống và nước mắm',
    ],
    stepsEn: [
      'Mix filling with seasonings',
      'Wrap filling in spring roll wrappers',
      'Brush egg yolk to seal',
      'Deep fry until golden and crispy',
      'Drain on paper towel',
      'Serve with fresh vegetables and fish sauce',
    ],
  ),
];
