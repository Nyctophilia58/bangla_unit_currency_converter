import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  String? _selectedValue;

  int get selectedIndex => _selectedIndex;
  String? get selectedValue => _selectedValue;

  SelectionProvider() {
    _loadSelection();
  }

  void _loadSelection() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    _selectedValue = prefs.getString('selectedValue');
    notifyListeners();
  }

  void selectIndex(int index) async {
    _selectedIndex = index;
    _selectedValue = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedIndex', index);
    await prefs.remove('selectedValue');
    notifyListeners();
  }

  void selectValue(String value) async {
    _selectedValue = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedValue', value);
    notifyListeners();
  }
}
