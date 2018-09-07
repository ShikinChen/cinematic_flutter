import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:cinematic_flutter/model/app_theme.dart';

final themeReducer = combineReducers<AppTheme>([
  TypedReducer<AppTheme, ToggleThemeAction>(_toggleThemeReducer),
  TypedReducer<AppTheme, LoadSettingAction>(_loadSettingReducer),
]);

AppTheme _toggleThemeReducer(AppTheme appTheme, toggleThemeAction) =>
    appTheme..currentThemeIndex = toggleThemeAction.themeIndex;

AppTheme _loadSettingReducer(AppTheme appTheme, loadSettingAction) =>
    appTheme..currentThemeIndex = loadSettingAction.themeIndex;
