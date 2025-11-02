import 'package:flutter/material.dart';
import 'models/app_state.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/create_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'utils/translations.dart';

void main() {
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatelessWidget {
  const RecipeBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sổ Công Thức',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MobileFrame(),
    );
  }
}

class MobileFrame extends StatefulWidget {
  const MobileFrame({super.key});

  @override
  State<MobileFrame> createState() => _MobileFrameState();
}

class _MobileFrameState extends State<MobileFrame> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const CreateScreen(),
    const SettingsScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: appStrings[AppState.language]!['nav_home'],
            ),
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: AppState.favoriteRecipes.isNotEmpty,
                label: Text('${AppState.favoriteRecipes.length}'),
                child: const Icon(Icons.favorite_border),
              ),
              activeIcon: Badge(
                isLabelVisible: AppState.favoriteRecipes.isNotEmpty,
                label: Text('${AppState.favoriteRecipes.length}'),
                child: const Icon(Icons.favorite),
              ),
              label: appStrings[AppState.language]!['nav_favorites'],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.add_circle_outline),
              activeIcon: const Icon(Icons.add_circle),
              label: appStrings[AppState.language]!['nav_create'],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings),
              label: appStrings[AppState.language]!['nav_settings'],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.info_outline),
              activeIcon: const Icon(Icons.info),
              label: appStrings[AppState.language]!['nav_about'],
            ),
          ],
        ),
      ),
    );
  }
}
