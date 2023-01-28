import 'package:flutter/material.dart';

class Apptheme {
  final dataTheme = ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      )
    ),
  );
}
