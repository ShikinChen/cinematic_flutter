import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:cinematic_flutter/page/media_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/page/home_page.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/reducer/app_state_reducer.dart';
import 'package:cinematic_flutter/common/common.dart';
import 'package:cinematic_flutter/middleware/store_app_middleware.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:cinematic_flutter/viewmodel/main_view_model.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.loggerName}__${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  runApp(new App());
}

class App extends StatelessWidget {
  final Logger logger = Logger('App');
  MainViewModel _vm;
  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.init(),
    middleware: createStoreAppMiddleware(),
  );

  @override
  Widget build(BuildContext context) => StoreProvider(
      store: store,
      child: StoreConnector<AppState, MainViewModel>(
        onInit: (store) {
          _vm = MainViewModel(store);
          if (_vm.loadSettingState == AppLoadState.notLoaded) {
            logger.fine('loadSetting');
            _vm.loadSetting();
          }
        },
        builder: (ctx, vm) => MaterialApp(
              theme: vm.currentThemeData,
              supportedLocales: [
                AppLocalizations.ZH_LOCALE,
                AppLocalizations.EN_LOCALE,
              ],
              localizationsDelegates: [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home: HomePage(),
            ),
        converter: (store) {
          _vm = _vm ?? MainViewModel(store);
          _vm.setAppState(store);
          return _vm;
        },
      ));
}
