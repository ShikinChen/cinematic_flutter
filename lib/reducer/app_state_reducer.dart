import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/reducer/theme_reducer.dart';
import 'package:cinematic_flutter/reducer/locale_reducer.dart';

AppState appStateReducer(AppState state, action) => state
  ..currentTheme = themeReducer(state.currentTheme, action)
  ..currentLocale = localeReducer(state.currentLocale, action);
