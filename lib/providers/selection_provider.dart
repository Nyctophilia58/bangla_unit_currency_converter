import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  final Map<int, String?> _firstSelectedValues = {};
  final Map<int, String?> _secondSelectedValues = {};

  int get selectedIndex => _selectedIndex;
  String? get firstSelectedValue => _firstSelectedValues[_selectedIndex];
  String? get secondSelectedValue => _secondSelectedValues[_selectedIndex];

  SelectionProvider() {
    _loadSelection();
  }

  void _loadSelection() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedIndex = prefs.getInt('selectedIndex') ?? 0;

    final firstStoredValue = prefs.getStringList('firstSelectedValues') ?? [];
    for (final entry in firstStoredValue) {
      final split = entry.split(':');
      if (split.length == 2) {
        final index = int.tryParse(split[0]);
        if (index != null) {
          _firstSelectedValues[index] = split[1];
        }
      }
    }

    final secondStoredValue = prefs.getStringList('secondSelectedValues') ?? [];
    for (final entry in secondStoredValue) {
      final split = entry.split(':');
      if (split.length == 2) {
        final index = int.tryParse(split[0]);
        if (index != null) {
          _secondSelectedValues[index] = split[1];
        }
      }
    }
    notifyListeners();
  }

  Future<void> _saveSelection() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> firstStoredMap = _firstSelectedValues.entries
        .where((e) => e.value != null)
        .map((e) => '${e.key}:${e.value}')
        .toList();
    await prefs.setStringList('firstSelectedValues', firstStoredMap);

    final List<String> secondStoredMap = _secondSelectedValues.entries
        .where((e) => e.value != null)
        .map((e) => '${e.key}:${e.value}')
        .toList();
    await prefs.setStringList('secondSelectedValues', secondStoredMap);
  }

  void selectIndex(int index) async {
    _selectedIndex = index;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedIndex', index);
    notifyListeners();
  }

  void selectFirstValue(String value) async {
    _firstSelectedValues[_selectedIndex] = value;
    await _saveSelection();
    notifyListeners();
  }

  void selectSecondValue(String value) async {
    _secondSelectedValues[_selectedIndex] = value;
    await _saveSelection();
    notifyListeners();
  }

}
