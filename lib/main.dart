import 'package:flutter/material.dart';
import 'pages/post_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dune Posts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Color Palette inspired by Dune
        primaryColor: const Color(0xFFe79b07),
        hintColor: const Color(0xFFf8c457),
        scaffoldBackgroundColor: const Color(0xFF3d2d1c),
        fontFamily: 'Roboto',

        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8c5c10),
          foregroundColor: Color(0xFFf8c457),
          elevation: 4,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFf8c457),
            fontFamily: 'Dune',
          ),
        ),

        // Card Theme
        cardTheme: CardThemeData(
          color: const Color(0xFF926506).withValues(alpha: 128),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFb29254)),
          ),
          elevation: 2,
        ),

        // Text Theme
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFFf8c457),
            fontSize: 16,
            fontFamily: 'Futura',
          ),
          bodyMedium: TextStyle(
            color: Color(0xFFb29254),
            fontSize: 14,
            fontFamily: 'Futura',
          ),
          titleLarge: TextStyle(
            color: Color(0xFFe79b07),
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'DidoLT',
          ),
          titleMedium: TextStyle(
            color: Color(0xFFf8c457),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'DidoLT',
          ),
        ),

        // ElevatedButton Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFe79b07),
            foregroundColor: const Color(0xFF3d2d1c),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Progress Indicator Theme
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFe79b07),
          circularTrackColor: Color(0xFF8c5c10),
        ),
      ),
      home: const PostListPage(),
    );
  }
}
