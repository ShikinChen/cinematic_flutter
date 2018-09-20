import 'package:cinematic_flutter/model/app_state.dart';
import 'package:flutter/material.dart';

class AppStateProvider extends InheritedWidget {
  final AppState appState;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  AppStateProvider({
    Key key,
    AppState appState,
    Widget child,
  })  : appState = appState ?? AppState(),
        super(
          key: key,
          child: child,
        );

  static AppState of(BuildContext ctx) =>
      (ctx.inheritFromWidgetOfExactType(AppStateProvider) as AppStateProvider)
          .appState;
}
