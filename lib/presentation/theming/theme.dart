import 'package:flutter/material.dart';

class AppTheme {
  AppTheme({
    this.isDarkMode = false,
  });

  final bool isDarkMode;

  ThemeData themeData() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: const Color.fromARGB(255, 58, 230, 64));
}
