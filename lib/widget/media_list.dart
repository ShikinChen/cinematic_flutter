import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/provider/media_provider.dart';
import 'package:cinematic_flutter/widget/media_list_item.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/bloc/media_bloc.dart';
import 'package:logging/logging.dart';

class MediaList extends StatelessWidget {
  final Logger logger = Logger('MediaListState');
  final _scrollController = new ScrollController();
  MediaBloc _mediaBloc;
  int _len = 0;
  bool _isEnd = false;

  Widget buildMediaList(BuildContext ctx, List<Media> list) {
    _mediaBloc = MediaProvider.of(ctx);
    _len = list.length;
    return RefreshIndicator(
      onRefresh: () async => _mediaBloc.getMediaList(),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _len <= 0 && !_isEnd ? 0 : _len + 1,
        itemBuilder: (ctx, index) {
          if (index >= _len) {
            return _buildProgressIndicator();
          }
          return MediaListItem(list[index]);
        },
      ),
    );
  }

  MediaList() {
    _scrollController.addListener(() {
      if (_mediaBloc != null &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isEnd) {
        _mediaBloc.getMediaListAction(len: _len);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaBloc = MediaProvider.of(context);
    return StreamBuilder<MediaListState>(
        stream: mediaBloc.mediaList,
        initialData: MediaListState(),
        builder: (BuildContext ctx, AsyncSnapshot<MediaListState> snapshot) {
          List<Media> list = snapshot.data.list;
          if (list!=null&&list.length <= 0) {
            _isEnd = true;
          }
          return snapshot.data.list == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : buildMediaList(context, list);
        });
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
