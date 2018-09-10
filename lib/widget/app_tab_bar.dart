import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:cinematic_flutter/viewmodel/app_tab_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/model/app_tab.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:redux/redux.dart';

class AppTabBar extends StatelessWidget {
  AppTabBarViewModel _vm;

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, AppTabBarViewModel>(
        converter: (store) {
          _vm = _vm ?? AppTabBarViewModel.fromStore(store);
          _vm.activeTabIndex = store.state.activeTabIndex;
          _vm.mediaType = store.state.mediaType;
          return _vm;
        },
        builder: _buildBottomNavigationBar,
      );

  BottomNavigationBar _buildBottomNavigationBar(
          BuildContext ctx, AppTabBarViewModel vm) =>
      BottomNavigationBar(
        onTap: vm.onTabSelected,
        currentIndex: vm.activeTabIndex,
        items: _getNavBarItems(ctx, vm),
      );

  List<BottomNavigationBarItem> _getNavBarItems(
      BuildContext ctx, AppTabBarViewModel vm) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.thumb_up),
        title: Text(
          AppLocalizations.of(ctx).popular,
        ),
      ),
      vm.mediaType == MediaType.movie
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
