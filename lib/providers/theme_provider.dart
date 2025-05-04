import 'package:flutter/material.dart';
import 'package:unit_currency_converter/themes/theme_mode.dart';
import "package:shared_preferences/shared_preferences.dart";


class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  ThemeProvider() {
    _loadThemePreference();
  }

  void _loadThemePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool("isDarkMode") ?? false;
    _themeData = isDark ? darkMode : lightMode;
    notifyListeners();
  }

  void toggleTheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool newIsDark = _themeData == lightMode;
    _themeData = newIsDark ? darkMode : lightMode;
    await prefs.setBool("isDarkMode", newIsDark);
    notifyListeners();
  }
}