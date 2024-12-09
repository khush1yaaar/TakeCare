import 'package:flutter/material.dart';

// Creating an instance of CustomTheme to manage the theme state.
CustomTheme currentTheme = CustomTheme();

// CustomTheme class to handle theme toggling and state management.
class CustomTheme with ChangeNotifier {
  // A static boolean to track the current theme (true for dark, false for light).
  static bool isDarkTheme = true;

  // Getter to return the current theme mode based on isDarkTheme.
  ThemeMode get currentTheme => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  // Method to toggle the theme and notify listeners.
  void toggleTheme() {
    isDarkTheme = !isDarkTheme; // Toggle the boolean value.
    notifyListeners(); // Notify listeners about the change.
  }

  // Getter to return the light theme data.
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.teal.shade100, // Dominant color: Slightly dark blue.
      scaffoldBackgroundColor: Colors.teal.shade100, // Secondary color: White.

      // AppBar theme settings for the light theme.
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.teal.shade300, // Dominant color: Slightly dark blue.
        titleTextStyle: TextStyle(color: Colors.teal.shade100), // Text style: Secondary color.
        iconTheme: IconThemeData(color: Colors.teal.shade100), // Icon theme: Secondary color.
      ),

      // Text theme settings for the light theme.
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.grey.shade800), // Dominant color.
        displayMedium: TextStyle(color: Colors.grey.shade800), // Dominant color.
        displaySmall: TextStyle(color: Colors.grey.shade800), // Dominant color.
        headlineLarge: TextStyle(color: Colors.teal.shade100), // Accent color.
        headlineMedium: TextStyle(color: Colors.teal.shade100), // Accent color.
        headlineSmall: TextStyle(color: Colors.teal.shade100), // Accent color.
        bodyLarge: TextStyle(color: Colors.grey.shade800), // Neutral for better contrast.
        bodyMedium: TextStyle(color: Colors.grey.shade800), // Neutral.
        bodySmall: TextStyle(color: Colors.grey.shade800), // Neutral.
      ),
    );
  }

  // Getter to return the dark theme data.
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.blueGrey.shade800, // Dominant color: Slightly dark blue.
      scaffoldBackgroundColor: Colors.teal.shade300, // Secondary color: Dark grey.

      // AppBar theme settings for the dark theme.
      appBarTheme: const AppBarTheme(
        backgroundColor:  Color(0xFF424242), // Dominant color.
        titleTextStyle: TextStyle(color: Color(0xFFEEEEEE),), // Accent color.
        iconTheme: IconThemeData(color: Color(0xFF424242)), // Accent color.
      ),

      // Text theme settings for the dark theme.
      textTheme: TextTheme(
        displayLarge: const TextStyle(color: Color(0xFF424242)), // Dominant color.
        displayMedium: const TextStyle(color: Color(0xFF424242)), // Dominant color.
        displaySmall: const TextStyle(color: Color(0xFF424242)), // Dominant color.
        headlineLarge: TextStyle(color: Colors.teal.shade300), // Accent color.
        headlineMedium: TextStyle(color: Colors.teal.shade300), // Accent color.
        headlineSmall: TextStyle(color: Colors.teal.shade300), // Accent color.
        bodyLarge: TextStyle(color: Colors.grey.shade300), // Neutral for better contrast.
        bodyMedium: TextStyle(color: Colors.grey.shade200), // Neutral.
        bodySmall: TextStyle(color: Colors.grey.shade50), // Neutral.
      ),

    );
  }
}
