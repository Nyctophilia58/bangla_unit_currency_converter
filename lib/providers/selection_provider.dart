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

  Future<void> _loadSelection() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _selectedIndex = prefs.getInt('selectedIndex') ?? 0;

      final firstStoredValue = prefs.getStringList('firstSelectedValues') ?? [];
      for (final entry in firstStoredValue) {
        final split = entry.split(':');
        if (split.length == 2) {
          final idx = int.tryParse(split[0]);
          if (idx != null) _firstSelectedValues[idx] = split[1];
        }
      }

      final secondStoredValue = prefs.getStringList('secondSelectedValues') ?? [];
      for (final entry in secondStoredValue) {
        final split = entry.split(':');
        if (split.length == 2) {
          final idx = int.tryParse(split[0]);
          if (idx != null) _secondSelectedValues[idx] = split[1];
        }
      }

      for (int i = 0; i < 5; i++) {
        _firstSelectedValues.putIfAbsent(i, () => null);
        _secondSelectedValues.putIfAbsent(i, () => null);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading selections: $e');
    }
  }

  Future<void> _saveSelection() async {
    try {
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

      await prefs.setInt('selectedIndex', _selectedIndex);
    } catch (e) {
      debugPrint('Error saving selections: $e');
    }
  }

  void selectIndex(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> selectFirstValue(String value) async {
    _firstSelectedValues[_selectedIndex] = value;
    await _saveSelection();
    notifyListeners();
  }

  Future<void> selectSecondValue(String value) async {
    _secondSelectedValues[_selectedIndex] = value;
    await _saveSelection();
    notifyListeners();
  }

  Future<void> resetCurrentCategory() async {
    _firstSelectedValues[_selectedIndex] = null;
    _secondSelectedValues[_selectedIndex] = null;
    await _saveSelection();
    notifyListeners();
  }

  Future<void> resetAllCategories() async {
    _firstSelectedValues.clear();
    _secondSelectedValues.clear();
    for (int i = 0; i < 5; i++) {
      _firstSelectedValues[i] = null;
      _secondSelectedValues[i] = null;
    }
    _selectedIndex = 0;
    await _saveSelection();
    notifyListeners();
  }
}
