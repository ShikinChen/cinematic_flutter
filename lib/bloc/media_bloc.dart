import 'dart:async';
import 'dart:convert';

import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/cast.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/media_category.dart';
import 'package:cinematic_flutter/model/media_detail.dart';
import 'package:cinematic_flutter/model/media_list_res.dart';
import 'package:cinematic_flutter/util/api_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MediaBloc {
  final Logger logger = Logger('MediaBloc');
  final PublishSubject<int> _pageController = PublishSubject<int>();
  final PublishSubject<int> _castController = PublishSubject<int>();
  final PublishSubject<int> _mediaDetailController = PublishSubject<int>();
  final PublishSubject<int> _similarListController = PublishSubject<int>();
  final PublishSubject<int> _saveCollectController = PublishSubject<int>();
  final PublishSubject<int> _getCollectController = PublishSubject<int>();
  final BehaviorSubject<MediaListState> _mediaListSubject =
      BehaviorSubject<MediaListState>();
  final BehaviorSubject<List<Cast>> _castListSubject =
      BehaviorSubject<List<Cast>>();

  final BehaviorSubject<MediaDetail> _mediaDetailSubject =
      BehaviorSubject<MediaDetail>();

  final BehaviorSubject<List<Media>> _similarListSubject =
      BehaviorSubject<List<Media>>();

  final BehaviorSubject<bool> _collectSubject = BehaviorSubject<bool>();

  final MediaListState mediaListState = MediaListState();

  MediaCategory mediaCategory = MediaCategory.popular;

  Stream<MediaListState> get mediaList => _mediaListSubject.stream;

  Stream<MediaDetail> get mediaDetail => _mediaDetailSubject.stream;

  Stream<List<Cast>> get castList => _castListSubject.stream;

  Stream<List<Media>> get similarList => _similarListSubject.stream;

  Stream<bool> get collect => _collectSubject.stream;

  Sink<int> get page => _pageController.sink;

  Sink<int> get castListFromId => _castController.sink;

  Sink<int> get mediaDetailFromId => _mediaDetailController.sink;

  Sink<int> get similarListFromId => _similarListController.sink;

  Sink<int> get saveCollect => _saveCollectController.sink;

  Sink<int> get getCollect => _getCollectController.sink;

  MediaBloc() {
    _pageController.stream.listen(getMediaList);
    _castController.stream.listen(_getCredits);
    _mediaDetailController.stream.listen(_getMediaDetail);
    _similarListController.stream.listen(_getSimilarList);
    _saveCollectController.stream.listen(_saveCollect);
    _getCollectController.stream.listen(_getCollect);
  }

  void _getCollect(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonText = await prefs.get(COLLECT_LIST_KEY);
    List<dynamic> list;
    if (jsonText != null) {
      list = JsonDecoder().convert(jsonText);
      _collectSubject.add(list.contains(id));
    } else {
      _collectSubject.add(false);
    }
  }

  void _saveCollect(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonText = await prefs.get(COLLECT_LIST_KEY);
    List<dynamic> list;
    if (jsonText == null) {
      list = List();
    } else {
      list = JsonDecoder().convert(jsonText);
    }
    if (!list.contains(id)) {
      list.add(id);
    } else {
      list.remove(id);
    }

    bool isSuccess =
        await prefs.setString(COLLECT_LIST_KEY, JsonEncoder().convert(list));
    if (isSuccess) {
      _collectSubject.add(list.contains(id));
    }
  }

  void _getCredits(int id) async {
    List<Cast> cast = await ApiClient().getCredits(id: id);
    _castListSubject.add(cast.map((cast) {
      if (cast.profilePath != null) {
        cast.profilePath = PROFILE_IMAGE_URL_MEDIUM + cast.profilePath;
      }
      return cast;
    }).toList());
  }

  void _getMediaDetail(int id) async {
    MediaDetail mediaDetail = await ApiClient().getMediaDetail(id: id);
    _mediaDetailSubject.add(mediaDetail);
  }

  void _getSimilarList(int id) async {
    List<Media> similarList = await ApiClient().getSimilarList(id: id);
    _similarListSubject.add(similarList.map((media) {
      if (media.posterPath != null) {
        media.posterPath = IMAGE_URL_MEDIUM + media.posterPath;
      }
      if (media.backdropPath != null) {
        media.backdropPath = IMAGE_URL_LARGE + media.backdropPath;
      }
      return media;
    }).toList());
  }

  void getMediaList([int len = 0]) async {
    if (len >= 0) {
      MediaListRes res = await ApiClient()
          .getMovieList(mediaCategory: mediaCategory, len: len);
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

  void getMediaListAction({int len: 0}) {
    this.page.add(len);
  }

  void getCastListAction(int id) {
    this.castListFromId.add(id);
  }

  void getMediaDetailAction(int id) {
    this.mediaDetailFromId.add(id);
  }

  void getSimilarListAction(int id) {
    this.similarListFromId.add(id);
  }

  void getCollectAction(int id) {
    this.getCollect.add(id);
  }

  void saveCollectAction(int id) {
    this.saveCollect.add(id);
  }
}

class MediaListState {
  List<Media> list;
}
