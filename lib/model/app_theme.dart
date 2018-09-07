import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final Logger log = new Logger('AppTheme');

class AppTheme {
  static get themes => [ThemeData.dark(), ThemeData.light()];

  int _currentThemeIndex;

  ThemeData _themeData;

  set currentThemeIndex(int value) {
    log.fine('_currentThemeIndex:${_currentThemeIndex}');
    _currentThemeIndex = value;
    _themeData = themes[_currentThemeIndex];
  }

  int get currentThemeIndex => _currentThemeIndex ?? 0;

  ThemeData get themeData => _themeData ?? themes[0];

  set themeData(ThemeData value) {
    _themeData = value;
  }
}
