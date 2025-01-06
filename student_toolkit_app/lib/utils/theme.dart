import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 2, 95, 86),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      elevation: 5,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 14),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.teal),
    ),
    labelStyle: TextStyle(color: Colors.teal),
    floatingLabelStyle: TextStyle(color: Colors.teal),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.teal,
    selectionHandleColor: Colors.teal,
    selectionColor: Color.fromARGB(77, 0, 150, 136),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  ),
  colorScheme: ColorScheme.light(
      scrim: Colors.grey[200],
      surface: const Color.fromARGB(226, 255, 255, 255),
      error: const Color.fromARGB(255, 240, 1, 21),
      onPrimary: Colors.white,
      primaryFixed: Colors.teal,
      onSurface: const Color(0xFF212121),
      onError: const Color(0xFF212121),
      primaryContainer: Colors.teal,
      primaryFixedDim: Colors.blue,
      secondaryContainer: const Color.fromARGB(255, 1, 146, 243)),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  primaryColor:
      const Color.fromARGB(255, 24, 28, 46), // A slightly lighter background
  scaffoldBackgroundColor:
      const Color.fromARGB(255, 25, 30, 39), // Darker but not completely black
  appBarTheme: const AppBarTheme(
    backgroundColor:
        Color.fromARGB(255, 38, 49, 80), // Adds depth to the app bar
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  cardColor:
      const Color.fromARGB(255, 23, 28, 36), // A subtle distinction for cards
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // Vibrant button color
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      elevation: 5,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color.fromARGB(255, 34, 38, 54), // Dark input field background
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue), // Matches primary
    ),
    labelStyle: TextStyle(color: Colors.white70),
    hintStyle: TextStyle(color: Colors.white54),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 14, color: Colors.white70),
    titleLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white70),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      labelStyle: const TextStyle(color: Colors.white70),
      hintStyle: const TextStyle(color: Colors.white54),
    ),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Color(0xFF2A2D3B),
    textStyle: TextStyle(color: Colors.white70),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF3D5AFE), // Vibrant blue
    secondary: Color(0xFF536DFE), // Softer secondary blue
    surface: Color.fromARGB(251, 27, 35, 50), // Blends with the dark theme
    error: Color(0xFFCF6679), // Vibrant error red
    onPrimary: Colors.white,
    onSecondary: Colors.white70,
    onSurface: Color.fromARGB(225, 255, 255, 255),
    onError: Colors.white,
    primaryContainer: Color.fromARGB(255, 44, 48, 65),
    secondaryContainer: Colors.blue,
    primaryFixed: Colors.blue,
    primaryFixedDim: Colors.blue,
    scrim: Color.fromARGB(251, 33, 43, 70),
  ),
);
