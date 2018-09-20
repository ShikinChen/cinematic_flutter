import 'package:cinematic_flutter/model/app_locale.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:flutter/material.dart';

class HomeViewModel {
  final Function(AppLocale) loadLocale;
  final Function(MediaType) onMediaTypeSelected;

  HomeViewModel(
    this.loadLocale,
    this.onMediaTypeSelected,
  );

  static HomeViewModel fromStore(Store<AppState> store) => HomeViewModel(
        (locale) {
          store.dispatch(LoadLocaleAction(locale));
        },
        (mediaType) {
          store.dispatch(MediaTypeSelectedAction(mediaType));
        },
      );
}
