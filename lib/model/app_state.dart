import 'dart:async';

import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:cinematic_flutter/model/app_tab.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:flutter/widgets.dart';
import 'package:cinematic_flutter/util/shared_preferences_util.dart';
import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/app_locale.dart';

class AppState {
  int activeTabIndex;
  MediaType mediaType = MediaType.movie;

  AppTheme currentTheme;
  AppLocale currentLocale;
  AppLoadState loadSettingState = AppLoadState.notLoaded;

  dynamic data;

  factory AppState.init() => AppState(
        currentTheme: AppTheme()..currentThemeIndex = 0,
      );

  AppState({
    this.activeTabIndex = 0,
    this.mediaType = MediaType.movie,
    @required this.currentTheme,
    this.currentLocale,
    this.loadSettingState = AppLoadState.notLoaded,
  });
}
