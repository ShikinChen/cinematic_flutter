import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final Logger logger = new Logger('AppTheme');

class AppTheme {
  static get themes => [ThemeData.light(), ThemeData.dark()];

  int _currentThemeIndex;

  ThemeData _themeData;

  set currentThemeIndex(int value) {
//    logger.fine('_currentThemeIndex:${_currentThemeIndex}');
    _currentThemeIndex = value??0;
    _themeData = themes[_currentThemeIndex];
  }

  int get currentThemeIndex => _currentThemeIndex ?? 0;

  ThemeData get themeData => _themeData ?? themes[0];

  set themeData(ThemeData value) {
    _themeData = value;
  }
}
