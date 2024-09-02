import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.blueGrey;
  static const Color textColor = Colors.white;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Color primario
    primaryColor: primary,
    // Tema del AppBar
    appBarTheme: const AppBarTheme(
      color: primary, 
      elevation: 0, 
      centerTitle: true, 
      titleTextStyle: TextStyle(fontSize: 20, color: textColor)
    ),
  );
}