import 'dart:async';

import 'package:cinematic_flutter/model/app_tab.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:cinematic_flutter/util/shared_preferences_util.dart';
import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/app_theme.dart';

class AppState {
  AppTab activeTab;
  AppTheme currentTheme;
  Locale currentLocale;
  bool isLoadedSetting = false;

  factory AppState.init() => AppState(
        currentTheme: AppTheme()..currentThemeIndex = 0,
      );

  AppState({
    this.activeTab = AppTab.popular,
    @required this.currentTheme,
    this.currentLocale,
    this.isLoadedSetting = false,
  });

  static Future<AppState> loading() async {
    return getSharedPreferencesInt(APP_THEME_KEY).then((value) {
      return AppState(
        currentTheme: AppTheme()..currentThemeIndex = value as int,
      );
    });
  }
}
