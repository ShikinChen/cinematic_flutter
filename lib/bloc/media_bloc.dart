import 'dart:async';

import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/media_category.dart';
import 'package:cinematic_flutter/model/media_list_res.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:cinematic_flutter/util/api_client.dart';
import 'package:cinematic_flutter/util/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

class MediaBloc {
  final Logger logger = Logger('MediaBloc');
  final PublishSubject<int> _pageController = PublishSubject<int>();
  final BehaviorSubject<MediaListState> _mediaListSubject =
      BehaviorSubject<MediaListState>();

  final MediaListState mediaListState = MediaListState();

  MediaCategory mediaCategory = MediaCategory.popular;
  MediaType mediaType = MediaType.movie;

  Stream<MediaListState> get mediaList => _mediaListSubject.stream;

  Sink<int> get page => _pageController.sink;

  MediaBloc() {
    _pageController.stream.listen(getMediaList);
  }

  void getMediaList([int len = 0]) async {
    if (len >= 0) {
      MediaListRes res = await ApiClient().getMovieList(
          mediaType: mediaType, mediaCategory: mediaCategory, len: len);
      List<Media> list = res.results.map((media) {
        if (media.backdropPath != null) {
          media.backdropPath = IMAGE_URL_LARGE + media.backdropPath;
        }
        if (media.posterPath != null) {
          media.posterPath = IMAGE_URL_MEDIUM + media.posterPath;
        }
        return media;
      }).toList();
      if (len <= 0) {
        mediaListState.list = list;
      } else {
        mediaListState.list.addAll(list);
      }
      logger.fine('list.length--${list.length}');
    } else {
      mediaListState.list = null;
      this.page.add(0);
    }
    _mediaListSubject.add(mediaListState);
  }

  void getMediaListAction({int len: 0}) async {
    this.page.add(len);
  }
}

class MediaListState {
  List<Media> list;
}
