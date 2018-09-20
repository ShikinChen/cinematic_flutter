import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:cinematic_flutter/model/app_locale.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:flutter/material.dart';

class ToggleThemeAction {
  final int themeIndex;

  ToggleThemeAction(this.themeIndex);
}

class LoadLocaleAction {
  final AppLocale locale;

  LoadLocaleAction(this.locale);
}

class LoadSettingAction {
  int themeIndex;
  AppLocale currentLocale;
  AppLoadState loadSettingState;
}

class TabSelectedAction {
  int activeTabIndex;

  TabSelectedAction(this.activeTabIndex);
}

class MediaTypeSelectedAction {
  MediaType mediaType;

  MediaTypeSelectedAction(this.mediaType);
}
