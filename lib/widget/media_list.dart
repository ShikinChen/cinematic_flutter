import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/widget/media_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/viewmodel/media_view_model.dart';
import 'package:logging/logging.dart';

class MediaList extends StatelessWidget {
  final MediaViewModel _vm = MediaViewModel();
  final Logger logger = Logger('MediaListState');
  final _scrollController = new ScrollController();

  MediaList() {
    _vm.page.add(1);
  }

  Widget buildMediaList(BuildContext ctx, List<Media> list) {
    return RefreshIndicator(
      onRefresh: () => null,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: list.length,
        itemBuilder: (ctx, index) => MediaListItem(list[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaListState>(
        stream: _vm.mediaList,
        initialData: MediaListState(),
        builder: (BuildContext ctx, AsyncSnapshot<MediaListState> snapshot) {
          return snapshot.data.list == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : buildMediaList(context, snapshot.data.list);
        });
  }
}
