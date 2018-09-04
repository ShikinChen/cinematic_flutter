import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/reducer/theme_reducer.dart';

AppState appStateReducer(AppState state, action) =>
    AppState()..currentTheme = themeReducer(state.currentTheme, action);
