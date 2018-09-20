import 'package:cinematic_flutter/model/app_locale.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';

final localeReducer = combineReducers<AppLocale>([
  TypedReducer<AppLocale, LoadLocaleAction>(_loadLocaleReducer),
  TypedReducer<AppLocale, LoadSettingAction>(_loadSettingReducer),
]);

AppLocale _loadLocaleReducer(AppLocale locale, loadLocaleAction) =>
    loadLocaleAction.locale;

AppLocale _loadSettingReducer(AppLocale locale, loadSettingAction) =>
    loadSettingAction.currentLocale;
