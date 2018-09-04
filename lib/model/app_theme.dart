import 'package:flutter/material.dart';

class AppTheme {
  static get themes => [ThemeData.dark(), ThemeData.light()];

  int _currentThemeIndex;

  ThemeData _themeData;

  set currentThemeIndex(int value) {
    print('_currentThemeIndex:${_currentThemeIndex}');
    _currentThemeIndex = value;
    _themeData = themes[_currentThemeIndex];
  }

  int get currentThemeIndex => _currentThemeIndex ?? 0;

  ThemeData get themeData => _themeData ?? themes[0];

  set themeData(ThemeData value) {
    _themeData = value;
  }
}
