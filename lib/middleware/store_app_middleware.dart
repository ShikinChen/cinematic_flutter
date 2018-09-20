import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:cinematic_flutter/model/app_locale.dart';
import 'package:cinematic_flutter/util/api_client.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:logging/logging.dart';
import 'package:cinematic_flutter/util/shared_preferences_util.dart';
import 'package:cinematic_flutter/constants.dart';

final Logger logger = Logger('store_app_middleware');

List<Middleware<AppState>> createStoreAppMiddleware() => [
      TypedMiddleware<AppState, ToggleThemeAction>(_toggleTheme()),
      TypedMiddleware<AppState, LoadLocaleAction>(_loadLocale()),
      TypedMiddleware<AppState, LoadSettingAction>(_loadSetting()),
      TypedMiddleware<AppState, TabSelectedAction>(_tabSelected()),
      TypedMiddleware<AppState, MediaTypeSelectedAction>(_mediaTypeSelected()),
    ];

Middleware<AppState> _toggleTheme() =>
    (Store<AppState> store, action, NextDispatcher next) {
      logger.fine('action.themeIndex:${action.themeIndex}');
      setSharedPreferencesInt(APP_THEME_KEY, action.themeIndex).then((b) {
        if (b) {
          next(action);
        }
      });
    };

Middleware<AppState> _loadLocale() =>
    (Store<AppState> store, action, NextDispatcher next) {
      if (store.state.currentLocale != action.locale) {
        setSharedPreferencesString(
                APP_LOCALE_KEY, action.locale.locale.languageCode)
            .then((b) {
          if (b) {
            AppLocalizations.load(action.locale.locale);
            setApiClientlanguage(action.locale.language);
            next(action);
          }
        });
      }
    };

Middleware<AppState> _loadSetting() =>
    (Store<AppState> store, action, NextDispatcher next) {
      logger.fine('_loadSetting');
      getSharedPreferencesValue(APP_THEME_KEY).then((value) {
        logger.fine('themeIndex:${value}');
        if (value != null) {
          action.themeIndex = value;
        }
        return getSharedPreferencesValue(APP_LOCALE_KEY);
      }).then((value) {
        AppLocale locale = AppLocalizations.getLocale(value);
        logger.fine('currentLocale:${value}');
        if (locale != null) {
          action.currentLocale = locale;
          AppLocalizations.load(locale.locale);
          setApiClientlanguage(locale.language);
        }
        action.loadSettingState = AppLoadState.loaded;
        next(action);
      });
    };

Middleware<AppState> _tabSelected() =>
    (Store<AppState> store, action, NextDispatcher next) {
      logger.fine('_tabSelected');
      next(action);
    };

Middleware<AppState> _mediaTypeSelected() =>
    (Store<AppState> store, action, NextDispatcher next) {
      next(action);
      store.dispatch(TabSelectedAction(0));
    };

setApiClientlanguage(String language) {
  if (language != null) {
    ApiClient().language = language;
  }
}
