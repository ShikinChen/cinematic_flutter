import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';

final loadSettingStateReducer = combineReducers<AppLoadState>([
  TypedReducer<AppLoadState, LoadSettingAction>(_loadSettingReducer),
]);

AppLoadState _loadSettingReducer(AppLoadState appLoadState, loadSettingAction) =>
    loadSettingAction.loadSettingState;

