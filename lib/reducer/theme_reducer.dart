import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:cinematic_flutter/model/app_theme.dart';

final themeReducer = combineReducers<AppTheme>([
  TypedReducer<AppTheme, ToggleThemeAction>(_toggleThemeReducer),
]);

AppTheme _toggleThemeReducer(AppTheme appTheme, toggleThemeAction) =>
    appTheme..currentThemeIndex = toggleThemeAction.themeIndex;
