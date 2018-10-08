import 'dart:async';

import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/app_locale.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:cinematic_flutter/model/genre.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:cinematic_flutter/util/api_client_util.dart';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/util/text_util.dart';

class AppStateBloc {
  VoidCallback _loadLocaleFunc;
  final Logger logger = Logger('AppStateBloc');

  final PublishSubject<int> _toggleThemeController = PublishSubject<int>();
  final PublishSubject<AppLocale> _loadLocaleController =
      PublishSubject<AppLocale>();
  final PublishSubject<int> _onTabSelectedController = PublishSubject<int>();
  final PublishSubject<MediaType> _onMediaTypeSelectedController =
      PublishSubject<MediaType>();

  final BehaviorSubject<AppState> appStateSubject = BehaviorSubject<AppState>();

  final AppState _appState = AppState.init();

  Stream<AppState> get appState => appStateSubject.stream;

//  Sink<dynamic> get loadSetting => _loadSettingController.sink;

  Sink<int> get toggleTheme => _toggleThemeController.sink;

  Sink<AppLocale> get loadLocale => _loadLocaleController.sink;

  Sink<int> get onTabSelected => _onTabSelectedController.sink;

  Sink<MediaType> get onMediaTypeSelected =>
      _onMediaTypeSelectedController.sink;

  AppStateBloc() {
    _toggleThemeController.stream.listen(_toggleTheme);
    _loadLocaleController.stream.listen(_loadLocale);
    _onTabSelectedController.stream.listen(_onTabSelected);
    _onMediaTypeSelectedController.stream.listen(_onMediaTypeSelected);
  }

  Future<AppState> loadSettingAction() async {
    logger.fine('_loadSetting');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = await prefs.get(LANGUAGE_KEY);
    if (language != null) {
      logger.fine('language--${language}');
      AppLocale appLocale = AppLocalizations.getLocale(language);
      AppLocalizations.load(appLocale.locale);
      _appState.currentLocale = appLocale;
    }

    int appTheme = await prefs.get(APP_THEME_KEY);
    if (appTheme != null) {
      _appState.currentTheme = AppTheme()..currentThemeIndex = appTheme;
    }

    return _appState;
  }

  void _toggleTheme(int currentTheme) async {
    logger.fine('currentTheme--${currentTheme}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSuccess = await prefs.setInt(APP_THEME_KEY, currentTheme);
    if (isSuccess) {
      _appState.currentTheme = AppTheme()..currentThemeIndex = currentTheme;
      appStateSubject.add(_appState);
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
        appStateSubject.add(_appState);
        if (_loadLocaleFunc != null) {
          _loadLocaleFunc();
        }
      }
    }
  }

  Future<AppState> getGenreAction(AppState appState) async {
    if (enGenreMap.length <= 0) {
      List<Genre> enMovieGenreListRes = await ApiClientUtil().getGenreList(
          mediaType: MediaType.movie,
          language: AppLocalizations.EN_LOCALE.language);

      enMovieGenreListRes.forEach((item) {
        enGenreMap[item.id] = item.name;
      });

      List<Genre> enTvGenreListRes = await ApiClientUtil().getGenreList(
          mediaType: MediaType.tv,
          language: AppLocalizations.EN_LOCALE.language);

      enTvGenreListRes.forEach((item) {
        enGenreMap[item.id] = item.name;
      });
    }
    if (cnGenreMap.length <= 0) {
      List<Genre> cnMovieGenreListRes = await ApiClientUtil().getGenreList(
          mediaType: MediaType.movie,
          language: AppLocalizations.ZH_LOCALE.language);

      cnMovieGenreListRes.forEach((item) {
        cnGenreMap[item.id] = item.name;
      });

      List<Genre> cnTvGenreListRes = await ApiClientUtil().getGenreList(
          mediaType: MediaType.tv,
          language: AppLocalizations.ZH_LOCALE.language);

      cnTvGenreListRes.forEach((item) {
        cnGenreMap[item.id] = item.name;
      });
    }
    appState.isLoadGenre = true;
    return appState;
  }

  void _onTabSelected(int index) {
    _appState.activeTabIndex = index;
    appStateSubject.add(_appState);
  }

  void _onMediaTypeSelected(MediaType mediaType) {
    _appState.mediaType = mediaType;
    _onTabSelected(0);
  }

  void toggleThemeAction() {
    toggleTheme.add((_appState.currentTheme.currentThemeIndex + 1) %
        AppTheme.themes.length);
  }

  void loadLocaleAction(AppLocale appLocale, VoidCallback loadLocaleFunc) {
    _loadLocaleFunc = loadLocaleFunc;
    loadLocale.add(appLocale);
  }

  void onTabSelectedAction(int index) {
    onTabSelected.add(index);
  }

  void onMediaTypeSelectedAction(MediaType mediaType) {
    onMediaTypeSelected.add(mediaType);
  }
}
