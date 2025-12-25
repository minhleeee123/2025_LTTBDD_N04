<div align="center">

# Recipe Book App

### Cross-Platform Mobile Recipe Management Application

<p align="center">
  <strong>Flutter Framework • Multi-language Support • Material Design 3 • Responsive UI • Local Storage</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.9+-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.9+-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Material-Design_3-757575?style=for-the-badge&logo=material-design&logoColor=white" alt="Material Design" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge" alt="Platform" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Production-success?style=flat-square" alt="Status" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square" alt="License" />
  <img src="https://img.shields.io/badge/Version-1.0.0-orange?style=flat-square" alt="Version" />
</p>

---

</div>

## Table of Contents

- [Quick Start](#quick-start)
- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Technology Stack](#technology-stack)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Screens & Navigation](#screens--navigation)
- [State Management](#state-management)
- [Internationalization](#internationalization)
- [API Reference](#api-reference)
- [Build & Deployment](#build--deployment)

---

## Quick Start

Get the app running on your device in 5 minutes:

```bash
# 1. Clone the repository
git clone https://github.com/minhleeee123/2025_LTTBDD_N04.git
cd 2025_LTTBDD_N04/recipe_app

# 2. Install Flutter dependencies
flutter pub get

# 3. Check device connection
flutter devices

# 4. Run the app
flutter run

# Or run on specific platform:
flutter run -d android
flutter run -d ios
flutter run -d chrome  # Web browser
```

**Prerequisites**: Flutter SDK 3.9+, Android Studio/Xcode

---

## Overview

Recipe Book is a modern mobile application built with Flutter that helps users discover, create, and manage their favorite cooking recipes. The app supports bilingual interface (Vietnamese and English) with an intuitive, Material Design 3-compliant UI.

### Key Highlights

**Cross-Platform**
- Single codebase for Android and iOS
- Consistent UI/UX across platforms
- Native performance

**Bilingual Support**
- Vietnamese and English interface
- Real-time language switching
- Localized recipe content

**User-Friendly**
- Intuitive navigation
- Smooth animations
- Responsive design for all screen sizes

**Feature-Rich**
- Recipe browsing and search
- Favorites management
- Custom recipe creation
- Detailed recipe view
- Category filtering

---

## Features

### Core Functionalities

#### 1. Home Screen - Recipe Discovery
- **Recipe Grid**: Responsive grid layout with recipe cards
- **Search**: Full-text search by recipe name and description
- **Category Filter**: Filter by All, Main Courses, Appetizers, Snacks
- **Expandable Header**: Collapsible search and filter section
- **Favorite Toggle**: Quick add/remove from favorites
- **Recipe Cards**: Display image, name, cooking time, and difficulty

#### 2. Favorites Screen - Personal Collection
- **Favorites List**: View all favorited recipes
- **Search & Filter**: Find specific favorites by name or category
- **Remove Favorites**: Quick removal from favorites list
- **Badge Counter**: Display favorite count on navigation bar
- **Empty State**: Helpful message when no favorites exist

#### 3. Create Screen - Recipe Builder
- **Bilingual Input**: Enter recipe name in Vietnamese and English
- **Rich Metadata**: Description, cooking time, servings, difficulty, category
- **Image URL**: Add recipe image link
- **Dynamic Ingredients**: Add/remove ingredients with bilingual support
- **Step-by-Step Instructions**: Add/remove cooking steps
- **Form Validation**: Complete validation before saving
- **Save Recipe**: Add to global recipe list

#### 4. Recipe Detail Screen - Detailed View
- **Hero Image**: Full-width image with SliverAppBar
- **Recipe Info**: Cooking time, servings, difficulty level
- **Ingredients List**: Bullet-pointed ingredient list
- **Cooking Steps**: Numbered step-by-step instructions
- **Floating Favorite**: Heart button overlay on image
- **Scrollable Content**: Smooth scrolling detail view

#### 5. Settings Screen - Customization
- **Language Switch**: Toggle between Vietnamese and English
- **Real-time Update**: UI updates immediately on language change
- **Persistent Settings**: Language preference saved locally

#### 6. About Screen - Developer Info
- **App Information**: Features and capabilities overview
- **Developer Profile**: Avatar and personal information
- **Skills Showcase**: Technology stack displayed as chips
- **Projects**: Portfolio of completed projects
- **Contact Links**: Email, GitHub, Facebook integration

---

## Architecture

### System Architecture

<div align="center">

```
┌────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                      │
│              (Screens & UI Components)                     │
│                                                            │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │   Home   │  │Favorites │  │  Create  │  │  Detail  │  │
│  │  Screen  │  │  Screen  │  │  Screen  │  │  Screen  │  │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘  │
│       │             │              │             │        │
│  ┌────┴─────┐  ┌────┴─────┐                              │
│  │Settings  │  │  About   │                              │
│  │ Screen   │  │  Screen  │                              │
│  └──────────┘  └──────────┘                              │
└────────────────────┬───────────────────────────────────────┘
                     │
                     │ State Updates
                     ▼
┌────────────────────────────────────────────────────────────┐
│                    BUSINESS LAYER                          │
│                (Models & State Logic)                      │
│                                                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                  AppState (Global)                   │  │
│  │  • language: String                                  │  │
│  │  • favoriteRecipes: List<Recipe>                     │  │
│  │  • allRecipes: List<Recipe>                          │  │
│  │                                                      │  │
│  │  Methods:                                            │  │
│  │  • isFavorite(Recipe)                                │  │
│  │  • toggleFavorite(Recipe)                            │  │
│  │  • addRecipe(Recipe)                                 │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    Recipe Model                      │  │
│  │  • id, nameVi, nameEn                                │  │
│  │  • descriptionVi, descriptionEn                      │  │
│  │  • imageUrl, duration, servings                      │  │
│  │  • difficulty, category                              │  │
│  │  • ingredientsVi/En, stepsVi/En                      │  │
│  │                                                      │  │
│  │  Methods:                                            │  │
│  │  • getName(language)                                 │  │
│  │  • getDescription(language)                          │  │
│  │  • getIngredients(language)                          │  │
│  │  • getSteps(language)                                │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────┬───────────────────────────────────────┘
                     │
                     │ Data Access
                     ▼
┌────────────────────────────────────────────────────────────┐
│                      DATA LAYER                            │
│               (Static Data & Utilities)                    │
│                                                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Sample Recipe Data                      │  │
│  │  • sampleRecipes: List<Recipe>                       │  │
│  │  • Pre-loaded recipes for demonstration              │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Translation Utilities                   │  │
│  │  • translate(key, language)                          │  │
│  │  • Translation maps for UI text                      │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────┘
```

</div>

### Architecture Pattern

The app uses a simplified **Layer Architecture** with three main layers:

1. **Presentation Layer**: UI screens and widgets
2. **Business Layer**: Models and state management
3. **Data Layer**: Static data and utilities

**State Management**: StatefulWidget with setState() for simplicity
**Navigation**: Named routes with Navigator 2.0
**Data Persistence**: In-memory storage (can be extended with SharedPreferences)

---

## Technology Stack

### Framework & Language

| Component | Technology | Version | Purpose |
|-----------|-----------|---------|---------|
| **Framework** | Flutter | 3.9+ | Cross-platform UI framework |
| **Language** | Dart | 3.9+ | Programming language |
| **Design** | Material Design 3 | Latest | UI design system |

### Core Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| **flutter_animate** | 4.5.0 | Smooth animations and transitions |
| **url_launcher** | 6.3.0 | Launch external URLs (email, web) |
| **cupertino_icons** | 1.0.8 | iOS-style icons |

### Development Tools

- **Flutter DevTools**: Debugging and profiling
- **Dart Analysis**: Static code analysis
- **Hot Reload**: Instant code updates during development

---

## Installation

### Prerequisites

#### Install Flutter SDK

**Windows**:
```bash
# Download Flutter SDK from https://flutter.dev
# Extract to C:\src\flutter
# Add to PATH: C:\src\flutter\bin
```

**macOS/Linux**:
```bash
# Download and extract Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
```

#### Install Platform-Specific Tools

**Android Development**:
- Install Android Studio
- Install Android SDK
- Create Android Emulator

**iOS Development** (macOS only):
- Install Xcode
- Install CocoaPods: `sudo gem install cocoapods`

#### Verify Installation

```bash
flutter doctor
```

Ensure all checkmarks are green.

### Project Setup

#### 1. Clone Repository

```bash
git clone https://github.com/minhleeee123/2025_LTTBDD_N04.git
cd 2025_LTTBDD_N04/recipe_app
```

#### 2. Install Dependencies

```bash
flutter pub get
```

#### 3. Run on Device

**Android**:
```bash
# Connect Android device or start emulator
flutter run -d android
```

**iOS** (macOS only):
```bash
# Connect iOS device or start simulator
cd ios
pod install
cd ..
flutter run -d ios
```

**Web Browser**:
```bash
flutter run -d chrome
```

#### 4. Build for Production

**Android APK**:
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

**iOS IPA** (macOS only):
```bash
flutter build ios --release
# Output: build/ios/iphoneos/Runner.app
```

---

## Project Structure

```
recipe_app/
├── lib/
│   ├── main.dart                      # Entry point & MaterialApp
│   ├── models/                        # Data models
│   │   ├── recipe.dart                # Recipe model & sample data
│   │   └── app_state.dart             # Global state management
│   ├── screens/                       # UI screens
│   │   ├── home_screen.dart           # Home screen
│   │   ├── favorites_screen.dart      # Favorites screen
│   │   ├── create_screen.dart         # Create recipe screen
│   │   ├── recipe_detail_screen.dart  # Recipe detail screen
│   │   ├── settings_screen.dart       # Settings screen
│   │   └── about_screen.dart          # About screen
│   └── utils/                         # Utilities
│       └── translations.dart          # i18n translations
├── android/                           # Android-specific code
├── ios/                               # iOS-specific code
├── web/                               # Web-specific code
├── test/                              # Unit tests
├── pubspec.yaml                       # Dependencies
└── README.md                          # This file
```

---

## Screens & Navigation

### Navigation Flow

```
Main App
│
├─ Bottom Navigation Bar
│  ├─ [0] Home Screen ────────┬─> Recipe Detail Screen
│  │                          │
│  ├─ [1] Favorites Screen ───┘
│  │
│  ├─ [2] Create Screen
│  │
│  ├─ [3] Settings Screen
│  │
│  └─ [4] About Screen
```

### Screen Details

#### Home Screen
- **Route**: `/`
- **Widget**: `HomeScreen`
- **Features**: Recipe grid, search, category filter
- **Navigation**: Tap recipe card → Recipe Detail

#### Favorites Screen
- **Route**: `/favorites`
- **Widget**: `FavoritesScreen`
- **Features**: Favorite recipes list, search, filter
- **Badge**: Shows favorite count

#### Create Screen
- **Route**: `/create`
- **Widget**: `CreateScreen`
- **Features**: Form inputs, validation, save recipe
- **Success**: Returns to Home Screen

#### Recipe Detail Screen
- **Route**: `/detail`
- **Widget**: `RecipeDetailScreen`
- **Parameters**: `Recipe` object
- **Features**: Full recipe information, favorite toggle

#### Settings Screen
- **Route**: `/settings`
- **Widget**: `SettingsScreen`
- **Features**: Language switcher
- **Effect**: Global language update

#### About Screen
- **Route**: `/about`
- **Widget**: `AboutScreen`
- **Features**: Developer info, contact links

---

## State Management

### Global State (AppState)

```dart
class AppState {
  // Current language ('vi' or 'en')
  static String language = 'vi';
  
  // List of favorite recipes
  static List<Recipe> favoriteRecipes = [];
  
  // All available recipes
  static List<Recipe> allRecipes = sampleRecipes;
  
  // Check if recipe is favorited
  static bool isFavorite(Recipe recipe) {
    return favoriteRecipes.any((r) => r.id == recipe.id);
  }
  
  // Toggle favorite status
  static void toggleFavorite(Recipe recipe) {
    if (isFavorite(recipe)) {
      favoriteRecipes.removeWhere((r) => r.id == recipe.id);
    } else {
      favoriteRecipes.add(recipe);
    }
  }
  
  // Add new recipe
  static void addRecipe(Recipe recipe) {
    allRecipes.add(recipe);
  }
}
```

### Local State

Each screen uses `StatefulWidget` with `setState()` for local UI state:

```dart
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  String selectedCategory = 'all';
  
  @override
  Widget build(BuildContext context) {
    // UI implementation
  }
}
```

---

## Internationalization

### Translation System

The app uses a custom translation utility:

```dart
// utils/translations.dart
String translate(String key, String language) {
  final translations = {
    'app_title': {
      'vi': 'Sổ Công Thức',
      'en': 'Recipe Book'
    },
    'search': {
      'vi': 'Tìm kiếm',
      'en': 'Search'
    },
    // ... more translations
  };
  
  return translations[key]?[language] ?? key;
}
```

### Supported Languages

- **Vietnamese (vi)**: Default language
- **English (en)**: Secondary language

### Language Switching

```dart
// In Settings Screen
ElevatedButton(
  onPressed: () {
    setState(() {
      AppState.language = newLanguage;
    });
    // Notify all screens to rebuild
  },
  child: Text('Switch Language')
)
```

All screens automatically update when language changes.

---

## API Reference

### Recipe Model

```dart
class Recipe {
  final String id;
  final String nameVi;
  final String nameEn;
  final String descriptionVi;
  final String descriptionEn;
  final String imageUrl;
  final int duration;           // in minutes
  final int servings;
  final String difficulty;      // 'easy', 'medium', 'hard'
  final String category;        // 'main', 'appetizer', 'snack'
  final List<String> ingredientsVi;
  final List<String> ingredientsEn;
  final List<String> stepsVi;
  final List<String> stepsEn;
  
  // Getters for current language
  String getName(String language);
  String getDescription(String language);
  List<String> getIngredients(String language);
  List<String> getSteps(String language);
}
```

### Creating New Recipe

```dart
final newRecipe = Recipe(
  id: DateTime.now().toString(),
  nameVi: 'Phở Bò',
  nameEn: 'Beef Pho',
  descriptionVi: 'Món phở truyền thống Việt Nam',
  descriptionEn: 'Traditional Vietnamese beef noodle soup',
  imageUrl: 'https://example.com/pho.jpg',
  duration: 120,
  servings: 4,
  difficulty: 'medium',
  category: 'main',
  ingredientsVi: ['500g thịt bò', '200g bánh phở'],
  ingredientsEn: ['500g beef', '200g rice noodles'],
  stepsVi: ['Luộc xương', 'Thái thịt'],
  stepsEn: ['Boil bones', 'Slice meat']
);

AppState.addRecipe(newRecipe);
```

---

## Build & Deployment

### Development Build

```bash
# Hot reload during development
flutter run

# Debug mode with logging
flutter run --debug
```

### Production Build

#### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

**Output Locations**:
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`

#### iOS (macOS only)

```bash
# Build IPA
flutter build ios --release

# Or use Xcode:
open ios/Runner.xcworkspace
# Then: Product > Archive
```

#### Web

```bash
flutter build web --release
```

**Output**: `build/web/`

### Deployment

**Google Play Store**:
1. Build app bundle: `flutter build appbundle`
2. Upload to Play Console
3. Complete store listing
4. Submit for review

**Apple App Store**:
1. Build with Xcode
2. Archive and upload to App Store Connect
3. Complete app information
4. Submit for review

---

## Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Widget Testing Example

```dart
testWidgets('Home screen displays recipes', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: HomeScreen()));
  
  expect(find.text('Recipe Book'), findsOneWidget);
  expect(find.byType(GridView), findsOneWidget);
});
```

---

## Performance Optimization

### Tips for Better Performance

1. **Lazy Loading**: Use `ListView.builder` instead of `ListView`
2. **Image Optimization**: Cache network images
3. **Build Optimization**: Use `const` constructors where possible
4. **State Management**: Minimize `setState()` calls
5. **Widget Reusability**: Extract reusable widgets

### Performance Profiling

```bash
flutter run --profile
# Then open DevTools
flutter pub global run devtools
```

---

## Troubleshooting

### Common Issues

**Issue: "Flutter not found"**
```bash
# Solution: Add Flutter to PATH
export PATH="$PATH:[PATH_TO_FLUTTER]/bin"
```

**Issue: "Gradle build failed"**
```bash
# Solution: Clean and rebuild
flutter clean
flutter pub get
flutter run
```

**Issue: "CocoaPods not installed"**
```bash
# Solution: Install CocoaPods
sudo gem install cocoapods
cd ios
pod install
```

**Issue: "Hot reload not working"**
```bash
# Solution: Restart app
# Press 'r' in terminal or
flutter run --hot
```

---

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

---

## License

This project is licensed under the MIT License.

---

## Acknowledgments

- **Flutter Team**: For the amazing framework
- **Material Design**: For design guidelines
- **Community**: For packages and support

---

<div align="center">

## Contact & Support

For questions or issues:
- Open an issue on GitHub
- Check Flutter documentation: https://flutter.dev
- Visit Flutter community: https://flutter.dev/community

**Built for Mobile Development Course Project**

Powered by Flutter Framework

---

**Cook with Confidence, Share with Love**

</div>
