import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/converter_constants.dart';

class SelectionProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  final Map<int, String?> _firstSelectedKeys = {};
  final Map<int, String?> _secondSelectedKeys = {};

  int get selectedIndex => _selectedIndex;
  String? get firstSelectedValue => _firstSelectedKeys[_selectedIndex];
  String? get secondSelectedValue => _secondSelectedKeys[_selectedIndex];

  SelectionProvider() {
    _loadSelection();
  }

  Future<void> _loadSelection() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _selectedIndex = prefs.getInt('selectedIndex') ?? 0;

      final firstStoredKeys = prefs.getStringList('firstSelectedKeys') ?? [];
      for (final entry in firstStoredKeys) {
        final split = entry.split(':');
        if (split.length == 2) {
          final idx = int.tryParse(split[0]);
          if (idx != null) _firstSelectedKeys[idx] = split[1];
        }
      }

      final secondStoredKeys = prefs.getStringList('secondSelectedKeys') ?? [];
      for (final entry in secondStoredKeys) {
        final split = entry.split(':');
        if (split.length == 2) {
          final idx = int.tryParse(split[0]);
          if (idx != null) _secondSelectedKeys[idx] = split[1];
        }
      }

      for (int i = 0; i < optionKeys.length; i++) {
        _firstSelectedKeys.putIfAbsent(i, () => null);
        _secondSelectedKeys.putIfAbsent(i, () => null);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading selections: $e');
    }
  }

  Future<void> _saveSelection() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> firstStoredMap = _firstSelectedKeys.entries
          .where((e) => e.value != null)
          .map((e) => '${e.key}:${e.value}')
          .toList();
      await prefs.setStringList('firstSelectedKeys', firstStoredMap);

      final List<String> secondStoredMap = _secondSelectedKeys.entries
          .where((e) => e.value != null)
          .map((e) => '${e.key}:${e.value}')
          .toList();
      await prefs.setStringList('secondSelectedKeys', secondStoredMap);

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

  Future<void> selectFirstValue(String key) async {
    _firstSelectedKeys[_selectedIndex] = key;
    await _saveSelection();
    notifyListeners();
  }

  Future<void> selectSecondValue(String key) async {
    _secondSelectedKeys[_selectedIndex] = key;
    await _saveSelection();
    notifyListeners();
  }

  Future<void> resetCurrentCategory() async {
    _firstSelectedKeys[_selectedIndex] = null;
    _secondSelectedKeys[_selectedIndex] = null;
    await _saveSelection();
    notifyListeners();
  }

  Future<void> resetAllCategories() async {
    _firstSelectedKeys.clear();
    _secondSelectedKeys.clear();
    for (int i = 0; i < optionKeys.length; i++) {
      _firstSelectedKeys[i] = null;
      _secondSelectedKeys[i] = null;
    }
    _selectedIndex = 0;
    await _saveSelection();
    notifyListeners();
  }
}
