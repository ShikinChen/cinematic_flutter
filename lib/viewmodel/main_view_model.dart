import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:flutter/material.dart';

class MainViewModel {
  final Store<AppState> _store;

  MainViewModel(this._store) {
    setAppState(_store);
  }

  setAppState(Store<AppState> store) {
    loadSettingState = store.state.loadSettingState;
    currentThemeData = store.state.currentTheme == null
        ? AppTheme.themes[0]
        : store.state.currentTheme.themeData;
  }

  AppLoadState loadSettingState = AppLoadState.notLoaded;

  ThemeData currentThemeData;

  loadSetting() {
    loadSettingState = AppLoadState.loading;
    _store.state.loadSettingState = AppLoadState.loading;
    _store.dispatch(LoadSettingAction());
  }
}
