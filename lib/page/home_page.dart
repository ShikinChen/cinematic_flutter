import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/widget/active_tab.dart';
import 'package:cinematic_flutter/model/app_tab.dart';
import 'package:cinematic_flutter/widget/media_list.dart';
import 'package:cinematic_flutter/common/app_localizations.dart';
import 'package:cinematic_flutter/widget/toggle_theme_button.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/common/localizations_keys.dart';

class HomePage extends StatelessWidget {
  final int dis = 2;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, ThemeData>(
        distinct: true,
        converter: (store) => store.state.currentTheme.themeData,
        builder: buildHome,
      );

  Widget buildHome(BuildContext ctx, ThemeData themeData) => Scaffold(
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
        drawer: buildDrawer(ctx),
      );

  Widget buildDrawer(BuildContext ctx) {
    List<_DrawerItem> list = createDrawerItemList(ctx);
    return Drawer(
      child: ListView.builder(
        itemBuilder: (ctx, index) => buildDrawerItem(ctx, list, index),
        itemCount: list.length + 1 + list.length ~/ dis,
      ),
    );
  }

  List<_DrawerItem> createDrawerItemList(BuildContext ctx) => [
        _DrawerItem(
          LocalizationsKeys.SEARCH_KEY,
          Icons.search,
        ),
        _DrawerItem(
          LocalizationsKeys.FAVORITES_KEY,
          Icons.favorite,
        ),
        _DrawerItem(
          LocalizationsKeys.MOVIES_KEY,
          Icons.local_movies,
        ),
        _DrawerItem(
          LocalizationsKeys.TV_SHOWS_KEY,
          Icons.live_tv,
        ),
        _DrawerItem(
          LocalizationsKeys.LANGUAGE_KEY,
          Icons.language,
        ),
      ];

  Widget buildDrawerItem(BuildContext ctx, List<_DrawerItem> list, int index) {
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
      title: Text(AppLocalizations.of(ctx).text(item.titleKey)),
      trailing: Icon(item.iconData),
      onTap: () {
        switch (item.titleKey) {
          case LocalizationsKeys.SEARCH_KEY:
            {}
            break;
          case LocalizationsKeys.FAVORITES_KEY:
            {}
            break;
          case LocalizationsKeys.MOVIES_KEY:
            {}
            break;
          case LocalizationsKeys.TV_SHOWS_KEY:
            {}
            break;
          case LocalizationsKeys.LANGUAGE_KEY:
            {
              showDialog(
                context: ctx,
                builder: (ctx) => SimpleDialog(
                      title: const Text('Select assignment'),
                      children: <Widget>[
                        new SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text('Treasury department'),
                        ),
                        new SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text('State department'),
                        ),
                      ],
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
  String titleKey;
  IconData iconData;

  _DrawerItem(this.titleKey, this.iconData);
}
