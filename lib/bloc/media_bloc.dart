import 'dart:async';

import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/media_list_res.dart';
import 'package:cinematic_flutter/util/api_client.dart';
import 'package:cinematic_flutter/util/date_time_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

class MediaBloc {
  final Logger logger = Logger('MediaBloc');
  final PublishSubject<int> _pageController = PublishSubject<int>();
  final BehaviorSubject<MediaListState> _mediaListSubject =
      BehaviorSubject<MediaListState>();

  final MediaListState mediaListState = MediaListState();

  Stream<MediaListState> get mediaList => _mediaListSubject.stream;

  Sink<int> get page => _pageController.sink;

  MediaBloc() {
    _pageController.stream.listen(_getMediaList);
  }

  void _getMediaList(int page) async {
    MediaListRes res = await ApiClient().getMovieList(page: page);
    List<Media> list = res.results.map((media) {
      if (media.backdropPath != null) {
        media.backdropPath = IMAGE_URL_LARGE + media.backdropPath;
      }
      if (media.posterPath != null) {
        media.posterPath = IMAGE_URL_MEDIUM + media.posterPath;
      }
      return media;
    }).toList();
    if (page <= 1) {
      mediaListState.list = list;
    } else {
      mediaListState.list.addAll(list);
    }
    _mediaListSubject.add(mediaListState);
  }
}

class MediaListState {
  List<Media> list;
}
