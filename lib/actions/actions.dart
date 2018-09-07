import 'package:flutter/material.dart';

class ToggleThemeAction {
  final int themeIndex;

  ToggleThemeAction(this.themeIndex);
}

class LoadLocaleAction {
  final Locale locale;

  LoadLocaleAction(this.locale);
}
