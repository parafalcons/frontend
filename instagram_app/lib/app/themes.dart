import 'package:flutter/material.dart';


/// Primary colors used in the app.
const primaryColor = Color.fromARGB(255, 18, 167, 187);
const lightSeedColor = Color.fromARGB(255, 18, 167, 187);
const darkSeedColor = Color.fromARGB(255, 18, 60, 80);

/// Additional colors for warnings and faded elements.
const cautionColor = Color.fromARGB(255, 228, 126, 19);
const fadedColor = Color.fromARGB(128, 255, 255, 255);

/// Opacity levels for UI elements.
const normalOpacity = 1.0;
const fadedOpacity = 0.3;

/// Light color scheme generated from the seed color.
/// It defines primary, secondary, background, and surface colors.
var lightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: lightSeedColor,
  primary: primaryColor,
);

/// Dark color scheme generated from the seed color.
/// It adapts primary, secondary, and background colors for dark mode.
var darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: darkSeedColor,
  primary: primaryColor,
);

/// **Light Theme Configuration**
/// - White background
/// - Light gray input fields
/// - Light-colored card backgrounds
/// - Darker text for readability
final lightTheme = ThemeData.light().copyWith(
  colorScheme: lightColorScheme,

  /// Sets the background color of the app.
  scaffoldBackgroundColor: Colors.white,

  /// AppBar styling for light mode.
  appBarTheme: AppBarTheme(
    foregroundColor: lightColorScheme.onPrimary, // Text & Icon color
    backgroundColor: lightColorScheme.primaryContainer, // Background color
  ),

  /// Card styling (used for UI elements like containers and buttons).
  cardTheme: CardTheme(
    color: lightColorScheme.surface, // Light-colored background for cards
  ),

  /// Input fields styling in light mode.
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200], // Light gray background for text fields
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), // Rounded corners
      borderSide: BorderSide.none, // No border outline
    ),
  ),
);

/// **Dark Theme Configuration**
/// - Black background
/// - Dark gray input fields
/// - Darker UI elements to match dark mode
/// - White text/icons for better contrast
final darkTheme = ThemeData.dark().copyWith(
  colorScheme: darkColorScheme,

  /// Sets the background color of the app in dark mode.
  scaffoldBackgroundColor: Colors.black,

  /// AppBar styling for dark mode.
  appBarTheme: AppBarTheme(
    foregroundColor: darkColorScheme.onPrimary, // White text & icons
    backgroundColor: darkColorScheme.primaryContainer, // Darker background
  ),

  /// Card styling for dark mode (e.g., used for UI containers).
  cardTheme: CardTheme(
    color: darkColorScheme.surface, // Dark-colored background for cards
  ),

  /// Input fields styling in dark mode.
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[900], // Dark gray background for text fields
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), // Rounded corners
      borderSide: BorderSide.none, // No border outline
    ),
  ),
);
