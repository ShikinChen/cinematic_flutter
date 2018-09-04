import 'package:cinematic_flutter/model/app_state.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:flutter/material.dart';

class ThemeViewModel {
  final VoidCallback toggleTheme;

  ThemeViewModel(this.toggleTheme);

  static ThemeViewModel fromStore(Store<AppState> store) => ThemeViewModel(
        () {
//          print('ThemeViewModel--ToggleThemeAction');
          store.dispatch(ToggleThemeAction());
        },
      );
}
