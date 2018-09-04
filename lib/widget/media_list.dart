import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/viewmodel/media_view_model.dart';

@immutable
class MediaList extends StatelessWidget {
  MediaViewModel _vm = MediaViewModel();

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, MediaViewModel>(
        converter: (store) => _vm,
        builder: (ctx, vm) => Center(
              child: Text('MovieList'),
            ),
      );
}
