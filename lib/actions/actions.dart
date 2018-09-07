import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:flutter/material.dart';

class ToggleThemeAction {
  final int themeIndex;

  ToggleThemeAction(this.themeIndex);
}

class LoadLocaleAction {
  final Locale locale;

  LoadLocaleAction(this.locale);
}

class LoadSettingAction {
  int themeIndex;
  Locale currentLocale;
  AppLoadState loadSettingState;
}
