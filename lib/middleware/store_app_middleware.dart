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
//      logger.fine('_loadLocale:${action.locale.languageCode}');
//      logger.fine('store.state.currentLocale:${store.state.currentLocale}');
      if (store.state.currentLocale != action.locale) {
//        logger.fine('store.state.currentLocale != action.locale');
        AppLocalizations.load(action.locale);
        next(action);
      }
    };
