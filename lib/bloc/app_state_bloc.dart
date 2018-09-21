import 'dart:async';

import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:cinematic_flutter/model/app_locale.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinematic_flutter/localizations.dart';

class AppStateBloc {
  final Logger logger = Logger('AppStateBloc');
  final PublishSubject<dynamic> _loadSettingController =
      PublishSubject<dynamic>();
  final PublishSubject<int> _toggleThemeController = PublishSubject<int>();
  final PublishSubject<AppLocale> _loadLocaleController =
      PublishSubject<AppLocale>();
  final PublishSubject<int> _onTabSelectedController = PublishSubject<int>();
  final PublishSubject<MediaType> _onMediaTypeSelectedController =
      PublishSubject<MediaType>();

  final BehaviorSubject<AppState> _appStateSubject =
      BehaviorSubject<AppState>();

  final AppState _appState = AppState.init();

  Stream<AppState> get appState => _appStateSubject.stream;

  Sink<dynamic> get loadSetting => _loadSettingController.sink;

  Sink<int> get toggleTheme => _toggleThemeController.sink;

  Sink<AppLocale> get loadLocale => _loadLocaleController.sink;

  Sink<int> get onTabSelected => _onTabSelectedController.sink;

  Sink<MediaType> get onMediaTypeSelected =>
      _onMediaTypeSelectedController.sink;

  AppStateBloc() {
    _loadSettingController.stream.listen(_loadSetting);
    _toggleThemeController.stream.listen(_toggleTheme);
    _loadLocaleController.stream.listen(_loadLocale);
    _onTabSelectedController.stream.listen(_onTabSelected);
    _onMediaTypeSelectedController.stream.listen(_onMediaTypeSelected);
  }

  void _loadSetting(_) async {
    logger.fine('_loadSetting');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = await prefs.get(LANGUAGE_KEY);
    if (language != null) {
      AppLocale appLocale = AppLocalizations.getLocale(language);
      AppLocalizations.load(appLocale.locale);
      _appState.currentLocale = appLocale;
    }

    int appTheme = await prefs.get(APP_THEME_KEY);
    if (appTheme != null) {
      _appState.currentTheme = AppTheme()..currentThemeIndex = appTheme;
    }
    _appStateSubject.add(_appState);
  }

  void _toggleTheme(int currentTheme) async {
    logger.fine('currentTheme--${currentTheme}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSuccess = await prefs.setInt(APP_THEME_KEY, currentTheme);
    if (isSuccess) {
      _appState.currentTheme = AppTheme()..currentThemeIndex = currentTheme;
      _appStateSubject.add(_appState);
    }
  }

  void _loadLocale(AppLocale appLocale) async {
    if (_appState.currentLocale != appLocale) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isSuccess =
          await prefs.setString(LANGUAGE_KEY, appLocale.locale.languageCode);
      if (isSuccess) {
        _appState.currentLocale = appLocale;
        AppLocalizations.load(appLocale.locale);
        _appStateSubject.add(_appState);
      }
    }
  }

  void _onTabSelected(int index) {
    _appState.activeTabIndex = index;
    _appStateSubject.add(_appState);
  }

  void _onMediaTypeSelected(MediaType mediaType) {
    _appState.mediaType = mediaType;
    _onTabSelected(0);
  }

  void loadSettingAction() {
    logger.fine('loadSettingAction');
    loadSetting.add(Null);
  }

  void toggleThemeAction() {
    toggleTheme.add((_appState.currentTheme.currentThemeIndex + 1) %
        AppTheme.themes.length);
  }

  void loadLocaleAction(AppLocale appLocale) {
    loadLocale.add(appLocale);
  }

  void onTabSelectedAction(int index) {
    onTabSelected.add(index);
  }

  void onMediaTypeSelectedAction(MediaType mediaType) {
    onMediaTypeSelected.add(mediaType);
  }
}
