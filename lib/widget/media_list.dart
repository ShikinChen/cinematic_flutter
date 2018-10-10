import 'dart:async';

import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/media_list_type.dart';
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
  MediaListType _mediaListType;

  Widget buildMediaList(BuildContext ctx, List<Media> list) {
    _mediaBloc = MediaProvider.of(ctx);
    _len = list.length;
    return RefreshIndicator(
      onRefresh: () async {
        if (this._mediaListType == MediaListType.collection) {
          return _mediaBloc.getCollectionMediaList();
        } else if (this._mediaListType == MediaListType.search) {
          return _mediaBloc.getMediaSearch();
        }
        return _mediaBloc.getMediaList();
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _len <= 0
            ? 0
            : this._mediaListType == MediaListType.collection
                ? _len
                : _isEnd ? _len : _len + 1,
        itemBuilder: (ctx, index) {
          if (index >= _len) {
            return _buildProgressIndicator();
          }
          return MediaListItem(list[index]);
        },
      ),
    );
  }

  MediaList({MediaListType mediaListType: MediaListType.list}) {
    this._mediaListType = mediaListType;
    _scrollController.addListener(() {
      if (_mediaBloc != null &&
          this._mediaListType != MediaListType.collection &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isEnd) {
        if (this._mediaListType == MediaListType.list) {
          _mediaBloc.getMediaListAction(len: _len);
        } else if (this._mediaListType == MediaListType.search) {
          _mediaBloc.mediaSearchAction(len: _len);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_mediaBloc == null) {
      _mediaBloc = MediaProvider.of(context);
    }
    Stream<MediaListState> stream = _mediaBloc.mediaList;
    MediaListState mediaListState = MediaListState();
    if (this._mediaListType == MediaListType.collection) {
      stream = _mediaBloc.collectMediaList;
    } else if (this._mediaListType == MediaListType.search) {
      stream = _mediaBloc.mediaSearchList;
      mediaListState.list = [];
    }
    return StreamBuilder<MediaListState>(
        stream: stream,
        initialData: mediaListState,
        builder: (BuildContext ctx, AsyncSnapshot<MediaListState> snapshot) {
          List<Media> list = snapshot.data.list;
          if (list != null) {
            if (list.length <= 0 || list.length == _len) {
              logger.fine('MediaList--list.length--${list.length}');
              _isEnd = true;
            } else {
              _isEnd = false;
            }
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
