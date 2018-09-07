import 'package:cinematic_flutter/model/app_state.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:flutter/material.dart';

class HomeViewModel {
  final Store<AppState> store;

  HomeViewModel(this.store);

  loadLocale(Locale locale) {
    store.dispatch(LoadLocaleAction(locale));
  }
}
