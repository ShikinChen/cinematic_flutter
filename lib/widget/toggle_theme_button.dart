import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/provider/app_state_provider.dart';
import 'package:flutter/material.dart';

class ToggleThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStateBloc = AppStateProvider.of(context);
    return IconButton(
      icon: Icon(
        Icons.color_lens,
        color: Colors.white,
      ),
      onPressed: () => appStateBloc.toggleThemeAction(),
    );
  }
}
