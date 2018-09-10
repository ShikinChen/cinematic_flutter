import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/viewmodel/theme_view_model.dart';

class ToggleThemeButton extends StatelessWidget {
  ThemeViewModel _vm;

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, ThemeViewModel>(
        distinct: true,
        converter: (store) => _vm = _vm ?? ThemeViewModel.fromStore(store),
        builder: (ctx, vm) => IconButton(
              icon: Icon(
                Icons.color_lens,
                color: Colors.white,
              ),
              onPressed: vm.toggleTheme,
            ),
      );
}
