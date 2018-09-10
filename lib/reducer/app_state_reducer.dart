import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/reducer/theme_reducer.dart';
import 'package:cinematic_flutter/reducer/locale_reducer.dart';
import 'package:cinematic_flutter/reducer/load_setting_state_reducer.dart';
import 'package:cinematic_flutter/reducer/active_tab_index_reducer.dart';
import 'package:cinematic_flutter/reducer/media_type_reducer.dart';

AppState appStateReducer(AppState state, action) => state
  ..currentTheme = themeReducer(state.currentTheme, action)
  ..currentLocale = localeReducer(state.currentLocale, action)
  ..loadSettingState = loadSettingStateReducer(state.loadSettingState, action)
  ..activeTabIndex = activeTabIndexReducer(state.activeTabIndex, action)
  ..mediaType = mediaTypeReducer(state.mediaType, action);
