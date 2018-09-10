import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';
import 'package:flutter/material.dart';

class AppTabBarViewModel {
  final Function(int) onTabSelected;
  int activeTabIndex;
  MediaType mediaType;

  AppTabBarViewModel(this.activeTabIndex, this.mediaType, this.onTabSelected);

  static AppTabBarViewModel fromStore(Store<AppState> store) =>
      AppTabBarViewModel(
        store.state.activeTabIndex,
        store.state.mediaType,
        (index) {
          store.dispatch(TabSelectedAction(index));
        },
      );
}
