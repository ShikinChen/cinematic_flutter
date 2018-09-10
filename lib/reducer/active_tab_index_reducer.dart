import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';

final activeTabIndexReducer = combineReducers<int>([
  TypedReducer<int, TabSelectedAction>(_activeTabIndexReducer),
]);

int _activeTabIndexReducer(int activeTabIndex, tabSelectedAction) =>
    tabSelectedAction.activeTabIndex;
