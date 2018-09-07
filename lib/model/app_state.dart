import 'dart:async';

import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:cinematic_flutter/model/app_tab.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:cinematic_flutter/util/shared_preferences_util.dart';
import 'package:cinematic_flutter/constants.dart';

class AppState {
  AppTab activeTab;
  AppTheme currentTheme;
  Locale currentLocale;
  AppLoadState loadSettingState = AppLoadState.notLoaded;

  factory AppState.init() => AppState(
        currentTheme: AppTheme()..currentThemeIndex = 0,
      );

  AppState({
    this.activeTab = AppTab.popular,
    @required this.currentTheme,
    this.currentLocale,
    this.loadSettingState = AppLoadState.notLoaded,
  });
}
