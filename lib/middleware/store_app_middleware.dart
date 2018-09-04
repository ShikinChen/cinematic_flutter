import 'package:redux/redux.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/actions/actions.dart';

List<Middleware<AppState>> createStoreAppMiddleware() => [
      TypedMiddleware<AppState, ToggleThemeAction>(_next()),
    ];

Middleware<AppState> _next() =>
    (Store<AppState> store, action, NextDispatcher next) {
      next(action);
    };
