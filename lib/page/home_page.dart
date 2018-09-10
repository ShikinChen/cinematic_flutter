import 'package:cinematic_flutter/model/media_type.dart';
import 'package:cinematic_flutter/widget/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/model/app_tab.dart';
import 'package:cinematic_flutter/widget/media_list.dart';
import 'package:cinematic_flutter/widget/toggle_theme_button.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/widget/language_dialog.dart';
import 'package:cinematic_flutter/viewmodel/home_view_model.dart';
import 'package:logging/logging.dart';

class HomePage extends StatelessWidget {
  final int dis = 2;
  final Logger logger = Logger('HomePage');
  HomeViewModel _vm;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, HomeViewModel>(
        distinct: true,
        onInit: (store) => _vm = HomeViewModel.fromStore(store),
        converter: (store) => _vm = _vm ?? HomeViewModel.fromStore(store),
        builder: buildHome,
      );

  Widget buildHome(BuildContext ctx, HomeViewModel vm) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(ctx).appTitle),
          actions: <Widget>[
            ToggleThemeButton(),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: MediaList(),
        drawer: buildDrawer(ctx, vm),
        bottomNavigationBar: AppTabBar(),
      );

  Widget buildDrawer(BuildContext ctx, HomeViewModel vm) {
    List<_DrawerItem> list = createDrawerItemList(ctx);
    return Drawer(
      child: ListView.builder(
        itemBuilder: (ctx, index) => buildDrawerItem(ctx, vm, list, index),
        itemCount: list.length + 1 + list.length ~/ dis,
      ),
    );
  }

  List<_DrawerItem> createDrawerItemList(BuildContext ctx) {
    AppLocalizations localizations = AppLocalizations.of(ctx);
    return [
      _DrawerItem(
        localizations.search,
        SEARCH_KEY,
        Icons.search,
      ),
      _DrawerItem(
        localizations.favorites,
        FAVORITES_KEY,
        Icons.favorite,
      ),
      _DrawerItem(
        localizations.movies,
        MOVIES_KEY,
        Icons.local_movies,
      ),
      _DrawerItem(
        localizations.tvShows,
        TV_SHOWS_KEY,
        Icons.live_tv,
      ),
      _DrawerItem(
        localizations.language,
        LANGUAGE_KEY,
        Icons.language,
      ),
    ];
  }

  Widget buildDrawerItem(
      BuildContext ctx, HomeViewModel vm, List<_DrawerItem> list, int index) {
    if (index == 0) {
      return DrawerHeader(
        padding: EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color(0xff2b5876),
              const Color(0xff4e4376),
            ]),
          ),
        ),
      );
    }

    int size = list.length ~/ dis;
    if (index % (dis + 1) == 0 && index != 0) {
      return Divider(
        height: 5.0,
      );
    }
    index--;
//    print('index-1:${index}--index ~/ dis:${(index-1) ~/ dis}');
    index = index > dis ? index - ((index - 1) ~/ size) : index;
//    print('index-2:${index}');
    _DrawerItem item = list[index];
    return ListTile(
      title: Text(item.title),
      trailing: Icon(item.iconData),
      onTap: () {
        switch (item.key) {
          case SEARCH_KEY:
            {
              Navigator.pop(ctx);
            }
            break;
          case FAVORITES_KEY:
            {
              Navigator.pop(ctx);
            }
            break;
          case MOVIES_KEY:
            {
              vm.onMediaTypeSelected(MediaType.movie);
              Navigator.pop(ctx);
            }
            break;
          case TV_SHOWS_KEY:
            {
              vm.onMediaTypeSelected(MediaType.tv);
              Navigator.pop(ctx);
            }
            break;
          case LANGUAGE_KEY:
            {
              showDialog(
                context: ctx,
                builder: (ctx) => LanguageDialog.of(
                      ctx,
                      vm,
                    ),
              );
            }
            break;
          default:
            break;
        }
      },
    );
  }
}

class _DrawerItem {
  String title;
  String key;
  IconData iconData;

  _DrawerItem(this.title, this.key, this.iconData);
}
