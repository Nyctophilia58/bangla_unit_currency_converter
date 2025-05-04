import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class LanguageProvider extends ChangeNotifier {
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  LanguageProvider() {
    _loadLanguagePreference();
  }

  void _loadLanguagePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isEnglish = prefs.getBool("isEnglish") ?? true;
    notifyListeners();
  }

  void toggleLanguage() async {
    _isEnglish = !_isEnglish;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isEnglish", _isEnglish);
    _loadLanguagePreference();
    notifyListeners();
  }

  void setLanguage(bool isEnglish) async {
    _isEnglish = isEnglish;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isEnglish", _isEnglish);
    notifyListeners();
  }
}