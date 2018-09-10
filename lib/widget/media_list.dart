import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/widget/media_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/viewmodel/media_view_model.dart';
import 'package:logging/logging.dart';

class MediaList extends StatelessWidget {
  MediaViewModel _vm;
  final Logger logger = Logger('MediaList');
  final _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, MediaViewModel>(
        onInit: (store) => _vm = MediaViewModel.fromStore(store),
        converter: (store) => _vm = _vm ?? MediaViewModel.fromStore(store),
        builder: (ctx, vm) => vm.list == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : buildMediaList(ctx, vm),
      );

  Widget buildMediaList(BuildContext ctx, MediaViewModel vm) =>
      RefreshIndicator(
        onRefresh: () => null,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: vm.list.length,
          itemBuilder: (ctx, index) => MediaListItem(vm.list[index]),
        ),
      );
}
