import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';

final localeReducer = combineReducers<Locale>([
  TypedReducer<Locale, LoadLocaleAction>(_loadLocaleReducer),
  TypedReducer<Locale, LoadSettingAction>(_loadSettingReducer),
]);

Locale _loadLocaleReducer(Locale locale, loadLocaleAction) =>
    loadLocaleAction.locale;

Locale _loadSettingReducer(Locale locale, loadSettingAction) =>
    loadSettingAction.currentLocale;
