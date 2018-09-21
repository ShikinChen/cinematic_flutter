import 'package:cinematic_flutter/model/app_load_state.dart';
import 'package:cinematic_flutter/model/app_theme.dart';
import 'package:cinematic_flutter/page/media_detail_page.dart';
import 'package:cinematic_flutter/provider/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/page/home_page.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/common/common.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:cinematic_flutter/bloc/app_state_bloc.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.loggerName}__${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  runApp(new App());
}

class App extends StatelessWidget {
  final Logger logger = Logger('App');

  final AppStateBloc appStateBloc = AppStateBloc();

  App() {
    appStateBloc.loadSettingAction();
  }

  @override
  Widget build(BuildContext context) => AppStateProvider(
        appStateBloc: appStateBloc,
        child: StreamBuilder<AppState>(
          stream: appStateBloc.appState,
          initialData: AppState.init(),
          builder: (BuildContext ctx, AsyncSnapshot<AppState> snapshot) =>
              MaterialApp(
                theme: snapshot.data.currentTheme.themeData,
                supportedLocales: [
                  AppLocalizations.ZH_LOCALE.locale,
                  AppLocalizations.EN_LOCALE.locale,
                ],
                localizationsDelegates: [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                home: Center(
                  child: HomePage(),
                ),
              ),
        ),
      );
}
