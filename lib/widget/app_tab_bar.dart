import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/model/media_category.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:cinematic_flutter/provider/app_state_provider.dart';
import 'package:cinematic_flutter/provider/media_provider.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:logging/logging.dart';

class AppTabBar extends StatelessWidget {
  final Logger logger = Logger('AppTabBar');

  @override
  Widget build(BuildContext context) {
    final appStateBloc = AppStateProvider.of(context);
    final mediaBloc = MediaProvider.of(context);
    return StreamBuilder<AppState>(
        stream: appStateBloc.appState,
        initialData: AppState.init(),
        builder: (BuildContext ctx, AsyncSnapshot<AppState> snapshot) {
          AppState appState = snapshot.data;
          return BottomNavigationBar(
            onTap: (int index) {
              appStateBloc.onTabSelectedAction(index);
              if (appState.mediaType != MediaType.movie && index == 1) {
//                logger.fine(
//                    'mediaBloc.mediaType--${mediaBloc.mediaType}__index--${index}');
                mediaBloc.mediaCategory = MediaCategory.on_the_air;
              } else {
                mediaBloc.mediaCategory = MediaCategory.values[index];
              }
              mediaBloc.getMediaListAction(len: -1);
            },
            currentIndex: snapshot.data.activeTabIndex,
            items: _getNavBarItems(ctx, snapshot.data),
          );
        });
  }

  List<BottomNavigationBarItem> _getNavBarItems(
      BuildContext ctx, AppState appState) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.thumb_up),
        title: Text(
          AppLocalizations.of(ctx).popular,
        ),
      ),
      appState.mediaType == MediaType.movie
          ? BottomNavigationBarItem(
              icon: Icon(Icons.update),
              title: Text(
                AppLocalizations.of(ctx).upcoming,
              ),
            )
          : BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              title: Text(
                AppLocalizations.of(ctx).onTheAir,
              ),
            ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star),
        title: Text(
          AppLocalizations.of(ctx).topRated,
        ),
      ),
    ];
  }
}
