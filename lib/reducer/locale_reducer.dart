import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';

final localeReducer = combineReducers<Locale>([
  TypedReducer<Locale, LoadLocaleAction>(_loadLocaleReducer),
]);

Locale _loadLocaleReducer(Locale locale, loadLocaleAction) =>
    loadLocaleAction.locale;
