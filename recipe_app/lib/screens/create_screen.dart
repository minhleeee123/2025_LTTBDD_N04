import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/app_state.dart';
import '../utils/translations.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameViController = TextEditingController();
  final _nameEnController = TextEditingController();
  final _descriptionViController = TextEditingController();
  final _descriptionEnController = TextEditingController();
  final _imageUrlController = TextEditingController();
  int _duration = 30;
  int _servings = 2;
  String _difficulty = 'easy';
  String _category = 'main';
  
  final List<TextEditingController> _ingredientViControllers = [TextEditingController()];
  final List<TextEditingController> _ingredientEnControllers = [TextEditingController()];
  final List<TextEditingController> _stepViControllers = [TextEditingController()];
  final List<TextEditingController> _stepEnControllers = [TextEditingController()];

  @override
  void dispose() {
    _nameViController.dispose();
    _nameEnController.dispose();
    _descriptionViController.dispose();
    _descriptionEnController.dispose();
    _imageUrlController.dispose();
    for (var controller in _ingredientViControllers) {
      controller.dispose();
    }
    for (var controller in _ingredientEnControllers) {
      controller.dispose();
    }
    for (var controller in _stepViControllers) {
      controller.dispose();
    }
    for (var controller in _stepEnControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _ingredientViControllers.add(TextEditingController());
      _ingredientEnControllers.add(TextEditingController());
    });
  }

  void _removeIngredient(int index) {
    if (_ingredientViControllers.length > 1) {
      setState(() {
        _ingredientViControllers[index].dispose();
        _ingredientViControllers.removeAt(index);
        _ingredientEnControllers[index].dispose();
        _ingredientEnControllers.removeAt(index);
      });
    }
  }

  void _addStep() {
    setState(() {
      _stepViControllers.add(TextEditingController());
      _stepEnControllers.add(TextEditingController());
    });
  }

  void _removeStep(int index) {
    if (_stepViControllers.length > 1) {
      setState(() {
        _stepViControllers[index].dispose();
        _stepViControllers.removeAt(index);
        _stepEnControllers[index].dispose();
        _stepEnControllers.removeAt(index);
      });
    }
  }

  void _saveRecipe() {
    if (_nameViController.text.isEmpty ||
        _nameEnController.text.isEmpty ||
        _descriptionViController.text.isEmpty ||
        _descriptionEnController.text.isEmpty ||
        _imageUrlController.text.isEmpty ||
        _ingredientViControllers.any((c) => c.text.isEmpty) ||
        _ingredientEnControllers.any((c) => c.text.isEmpty) ||
        _stepViControllers.any((c) => c.text.isEmpty) ||
        _stepEnControllers.any((c) => c.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(appStrings[AppState.language]!['fill_all_fields']!),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newRecipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nameVi: _nameViController.text,
      nameEn: _nameEnController.text,
      descriptionVi: _descriptionViController.text,
      descriptionEn: _descriptionEnController.text,
      imageUrl: _imageUrlController.text,
      duration: _duration,
      servings: _servings,
      difficulty: _difficulty,
      category: _category,
      ingredientsVi: _ingredientViControllers.map((c) => c.text).toList(),
      ingredientsEn: _ingredientEnControllers.map((c) => c.text).toList(),
      stepsVi: _stepViControllers.map((c) => c.text).toList(),
      stepsEn: _stepEnControllers.map((c) => c.text).toList(),
    );

    AppState.addRecipe(newRecipe);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(appStrings[AppState.language]!['recipe_saved']!),
        backgroundColor: Colors.green,
      ),
    );

    // Clear form
    _nameViController.clear();
    _nameEnController.clear();
    _descriptionViController.clear();
    _descriptionEnController.clear();
    _imageUrlController.clear();
    setState(() {
      _duration = 30;
      _servings = 2;
      _difficulty = 'easy';
      _category = 'main';
      _ingredientViControllers.clear();
      _ingredientViControllers.add(TextEditingController());
      _ingredientEnControllers.clear();
      _ingredientEnControllers.add(TextEditingController());
      _stepViControllers.clear();
      _stepViControllers.add(TextEditingController());
      _stepEnControllers.clear();
      _stepEnControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          appStrings[AppState.language]!['create_title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Info Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe Name Vietnamese
                    _buildSectionTitle('${appStrings[AppState.language]!['recipe_name']!} (Tiếng Việt)'),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: _nameViController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'VD: Phở Việt Nam',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Recipe Name English
              _buildSectionTitle('${appStrings[AppState.language]!['recipe_name']!} (English)'),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: _nameEnController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Ex: Vietnamese Pho',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description Vietnamese
              _buildSectionTitle('${appStrings[AppState.language]!['description']!} (Tiếng Việt)'),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionViController,
                maxLines: 2,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Mô tả ngắn về món ăn',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
              const SizedBox(height: 12),

              // Description English
              _buildSectionTitle('${appStrings[AppState.language]!['description']!} (English)'),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionEnController,
                maxLines: 2,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Brief description',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
              const SizedBox(height: 20),

              // Image URL
              _buildSectionTitle(appStrings[AppState.language]!['image_url']!),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: _imageUrlController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: appStrings[AppState.language]!['image_url_hint'],
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Duration and Servings
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(appStrings[AppState.language]!['duration_label']!),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('$_duration', style: const TextStyle(fontSize: 16)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () => setState(() => _duration += 5),
                                    child: const Icon(Icons.arrow_drop_up),
                                  ),
                                  InkWell(
                                    onTap: () => setState(() {
                                      if (_duration > 5) _duration -= 5;
                                    }),
                                    child: const Icon(Icons.arrow_drop_down),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(appStrings[AppState.language]!['servings_label']!),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('$_servings', style: const TextStyle(fontSize: 16)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () => setState(() => _servings++),
                                    child: const Icon(Icons.arrow_drop_up),
                                  ),
                                  InkWell(
                                    onTap: () => setState(() {
                                      if (_servings > 1) _servings--;
                                    }),
                                    child: const Icon(Icons.arrow_drop_down),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Difficulty
              _buildSectionTitle(appStrings[AppState.language]!['difficulty_label']!),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildDifficultyChip('easy', appStrings[AppState.language]!['difficulty_easy']!),
                  const SizedBox(width: 8),
                  _buildDifficultyChip('medium', appStrings[AppState.language]!['difficulty_medium']!),
                  const SizedBox(width: 8),
                  _buildDifficultyChip('hard', appStrings[AppState.language]!['difficulty_hard']!),
                ],
              ),
              const SizedBox(height: 20),

              // Category
              _buildSectionTitle(appStrings[AppState.language]!['category_label']!),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildCategoryChip('main', appStrings[AppState.language]!['category_main']!),
                  const SizedBox(width: 8),
                  _buildCategoryChip('appetizer', appStrings[AppState.language]!['category_appetizer']!),
                  const SizedBox(width: 8),
                  _buildCategoryChip('snack', appStrings[AppState.language]!['category_snack']!),
                    ],
                  ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Ingredients
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(appStrings[AppState.language]!['ingredients_label']!, isLarge: true),
                    const SizedBox(height: 8),
                    ..._ingredientViControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final viController = entry.value;
                final enController = _ingredientEnControllers[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Nguyên liệu ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const Spacer(),
                            if (_ingredientViControllers.length > 1)
                              IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red, size: 20),
                                onPressed: () => _removeIngredient(index),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: viController,
                          decoration: InputDecoration(
                            labelText: 'Tiếng Việt',
                            hintText: 'VD: 500g thịt bò',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: enController,
                          decoration: InputDecoration(
                            labelText: 'English',
                            hintText: 'Ex: 500g beef',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                    }).toList(),
                    TextButton.icon(
                      onPressed: _addIngredient,
                      icon: const Icon(Icons.add),
                      label: Text(appStrings[AppState.language]!['add_ingredient']!),
                      style: TextButton.styleFrom(foregroundColor: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Steps
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(appStrings[AppState.language]!['steps_label']!, isLarge: true),
                    const SizedBox(height: 8),
                    ..._stepViControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final viController = entry.value;
                final enController = _stepEnControllers[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('Bước ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const Spacer(),
                            if (_stepViControllers.length > 1)
                              IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red, size: 20),
                                onPressed: () => _removeStep(index),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: viController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'Tiếng Việt',
                            hintText: 'VD: Ninh xương bò với hành, gừng trong 3 tiếng',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: enController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'English',
                            hintText: 'Ex: Simmer beef bones with onion and ginger for 3 hours',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                    }).toList(),
                    TextButton.icon(
                      onPressed: _addStep,
                      icon: const Icon(Icons.add),
                      label: Text(appStrings[AppState.language]!['add_step']!),
                      style: TextButton.styleFrom(foregroundColor: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveRecipe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    appStrings[AppState.language]!['save_recipe']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool isLarge = false}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isLarge ? 16 : 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDifficultyChip(String difficulty, String label) {
    final isSelected = _difficulty == difficulty;
    return GestureDetector(
      onTap: () {
        setState(() {
          _difficulty = difficulty;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? Colors.black : Colors.grey.shade300, width: 0.8),
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

  Widget _buildCategoryChip(String category, String label) {
    final isSelected = _category == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _category = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? Colors.black : Colors.grey.shade300, width: 0.8),
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
}
