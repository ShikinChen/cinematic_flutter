import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/bloc/app_state_bloc.dart';
import 'package:flutter/material.dart';

class AppStateProvider extends InheritedWidget {
  final AppStateBloc appStateBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  AppStateProvider({
    Key key,
    AppStateBloc appStateBloc,
    Widget child,
  })  : appStateBloc = appStateBloc ?? AppStateBloc(),
        super(
          key: key,
          child: child,
        );

  static AppStateBloc of(BuildContext ctx) =>
      (ctx.inheritFromWidgetOfExactType(AppStateProvider) as AppStateProvider)
          .appStateBloc;
}
