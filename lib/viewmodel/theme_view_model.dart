import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:flutter/material.dart';

class ThemeViewModel {
  final VoidCallback toggleTheme;

  ThemeViewModel(this.toggleTheme);

  static ThemeViewModel fromStore(Store<AppState> store) => ThemeViewModel(
        () {
          store.dispatch(ToggleThemeAction(
              (store.state.currentTheme.currentThemeIndex + 1) %
                  AppTheme.themes.length));
        },
      );
}
