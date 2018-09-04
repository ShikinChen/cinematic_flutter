import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/page/home_page.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/reducer/app_state_reducer.dart';
import 'package:cinematic_flutter/common/common.dart';
import 'package:cinematic_flutter/middleware/store_app_middleware.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState(),
    middleware: createStoreAppMiddleware(),
  );

  @override
  Widget build(BuildContext context) => StoreProvider(
      store: store,
      child: StoreConnector<AppState, ThemeData>(
        builder: (ctx, themeData) => MaterialApp(
              theme: themeData,
              localizationsDelegates: [
                AppLocalizationsDelegate(),
              ],
              routes: {
                Routes.home: (ctx) => HomePage(),
              },
            ),
        converter: (store) => store.state.currentTheme.themeData,
      ));
}
