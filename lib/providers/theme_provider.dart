import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark,
  system,
}

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeData.dark();

  final Color _lightPrimaryColor = Colors.green;
  final Color _lightOnPrimaryColor = Colors.grey[200]!;
  final Color _lightTextColor = Colors.black;
  final Color _lightBackGroundColor = Colors.white;
  final Color _lightOnBackGroundColor = Colors.grey[400]!;

  final Color _darkPrimaryColor = Colors.purple;
  final Color _darkOnPrimaryColor = Colors.grey[200]!;
  final Color _darkTextColor = Colors.white;
  final Color _darkBackGroundColor = Colors.black26;
  final Color _darkOnBackGroundColor = Colors.black87;

  ThemeProvider() {
    _applySystemTheme();
  }

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        setTheme(_buildLightTheme());
        break;
      case AppTheme.dark:
        setTheme(_buildDarkTheme());
        break;
      case AppTheme.system:
        _applySystemTheme();
        break;
    }
  }

  void _applySystemTheme() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark) {
      setTheme(_buildDarkTheme());
    } else {
      setTheme(_buildLightTheme());
    }
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        onPrimary: _lightOnPrimaryColor,
        background: _lightBackGroundColor,
        onBackground: _lightOnBackGroundColor,

      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: _lightTextColor),
        displayMedium: TextStyle(color: _lightTextColor),
        displaySmall: TextStyle(color: _lightTextColor),
        headlineMedium: TextStyle(color: _lightTextColor),
        headlineSmall: TextStyle(color: _lightTextColor),
        titleLarge: TextStyle(color: _lightTextColor),
        titleMedium: TextStyle(color: _lightTextColor),
        titleSmall: TextStyle(color: _lightTextColor),
        bodyLarge: TextStyle(color: _lightTextColor),
        bodyMedium: TextStyle(color: _lightTextColor),
        bodySmall: TextStyle(color: _lightTextColor),
        labelLarge: TextStyle(color: _lightTextColor),
        labelSmall: TextStyle(color: _lightTextColor),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: _darkPrimaryColor,
        onPrimary: _darkOnPrimaryColor,
        background: _darkBackGroundColor,
        onBackground: _darkOnBackGroundColor,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: _darkTextColor),
        displayMedium: TextStyle(color: _darkTextColor),
        displaySmall: TextStyle(color: _darkTextColor),
        headlineMedium: TextStyle(color: _darkTextColor),
        headlineSmall: TextStyle(color: _darkTextColor),
        titleLarge: TextStyle(color: _darkTextColor),
        titleMedium: TextStyle(color: _darkTextColor),
        titleSmall: TextStyle(color: _darkTextColor),
        bodyLarge: TextStyle(color: _darkTextColor),
        bodyMedium: TextStyle(color: _darkTextColor),
        bodySmall: TextStyle(color: _darkTextColor),
        labelLarge: TextStyle(color: _darkTextColor),
        labelSmall: TextStyle(color: _darkTextColor),
      ),
    );
  }
}



