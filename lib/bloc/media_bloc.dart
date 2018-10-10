import 'dart:async';
import 'dart:convert';

import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/cast.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/media_bean.dart';
import 'package:cinematic_flutter/model/media_category.dart';
import 'package:cinematic_flutter/model/media_detail.dart';
import 'package:cinematic_flutter/model/media_list_res.dart';
import 'package:cinematic_flutter/util/api_client_util.dart';
import 'package:cinematic_flutter/util/sqflite_util.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

class MediaBloc {
  final Logger logger = Logger('MediaBloc');

  SqfliteAdapter _adapter;
  MediaBean _mediaBean;

  String _keyword;

//PublishSubject
  final PublishSubject<int> _pageController = PublishSubject<int>();
  final PublishSubject<Media> _castController = PublishSubject<Media>();
  final PublishSubject<Media> _mediaDetailController = PublishSubject<Media>();
  final PublishSubject<Media> _similarListController = PublishSubject<Media>();
  final PublishSubject<Media> _saveCollectController = PublishSubject<Media>();
  final PublishSubject<int> _getCollectController = PublishSubject<int>();
  final PublishSubject<dynamic> _getCollectionMediaListController =
      PublishSubject<dynamic>();
  final PublishSubject<Map<String, dynamic>> _mediaSearchController =
      PublishSubject<Map<String, dynamic>>();

//BehaviorSubject
  final BehaviorSubject<MediaListState> _mediaListSubject =
      BehaviorSubject<MediaListState>();
  final BehaviorSubject<List<Cast>> _castListSubject =
      BehaviorSubject<List<Cast>>();
  final BehaviorSubject<MediaListState> _collectMediaListSubject =
      BehaviorSubject<MediaListState>();
  final BehaviorSubject<MediaDetail> _mediaDetailSubject =
      BehaviorSubject<MediaDetail>();
  final BehaviorSubject<List<Media>> _similarListSubject =
      BehaviorSubject<List<Media>>();
  final BehaviorSubject<bool> _collectSubject = BehaviorSubject<bool>();
  final BehaviorSubject<MediaListState> _mediaSearchListSubject =
      BehaviorSubject<MediaListState>();

  final MediaListState mediaListState = MediaListState();

  final MediaListState collectionMediaListState = MediaListState();

  final MediaListState searchMediaListState = MediaListState();

  MediaCategory mediaCategory = MediaCategory.popular;

//Stream
  Stream<MediaListState> get mediaList => _mediaListSubject.stream;

  Stream<MediaListState> get collectMediaList =>
      _collectMediaListSubject.stream;

  Stream<MediaDetail> get mediaDetail => _mediaDetailSubject.stream;

  Stream<List<Cast>> get castList => _castListSubject.stream;

  Stream<List<Media>> get similarList => _similarListSubject.stream;

  Stream<bool> get collect => _collectSubject.stream;

  Stream<MediaListState> get mediaSearchList => _mediaSearchListSubject.stream;

//Sink
  Sink<int> get page => _pageController.sink;

  Sink<Media> get castListFromId => _castController.sink;

  Sink<Media> get mediaDetailFromMedia => _mediaDetailController.sink;

  Sink<Media> get similarListFromId => _similarListController.sink;

  Sink<Media> get saveCollect => _saveCollectController.sink;

  Sink<dynamic> get getCollect => _getCollectController.sink;

  Sink<Map<String, dynamic>> get mediaSearch => _mediaSearchController.sink;

  MediaBloc() {
    _pageController.stream.listen(getMediaList);
    _castController.stream.listen(_getCredits);
    _mediaDetailController.stream.listen(_getMediaDetail);
    _similarListController.stream.listen(_getSimilarList);
    _saveCollectController.stream.listen(_saveCollect);
    _getCollectController.stream.listen(_getCollect);
    _getCollectionMediaListController.stream.listen(getCollectionMediaList);
    _mediaSearchController.stream
        .distinct()
        .debounce(const Duration(milliseconds: 250))
        .listen(getMediaSearch);
  }

  void getMediaSearch([Map<String, dynamic> params]) async {
    String keyword;
    int len = 0;
    if (params != null) {
      keyword = params['keyword'];
      len = params['len'];
    }
    if (searchMediaListState.list == null) {
      searchMediaListState.list = [];
    }
    if (keyword == null) {
      searchMediaListState.list.clear();
    } else {
      MediaListRes res =
          await ApiClientUtil().getMediaSearch(query: keyword, len: len);
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
        searchMediaListState.list = list;
      } else {
        searchMediaListState.list.addAll(list);
      }
    }
    _mediaSearchListSubject.add(searchMediaListState);
  }

  void _saveCollect(Media media) async {
    logger.fine('_saveCollect--media--${media.toString()}');
    await initMediaBean();
    media.genreIdsJson = JsonEncoder().convert(media.genreIds);
    Media tmp = await _mediaBean.find(media.id);
    int count = 0;
    if (tmp == null) {
      logger.fine('insert');
      count = await _mediaBean.insert(media);
      if (count > 0) {
        _collectSubject.add(true);
      }
    } else {
      logger.fine('remove');
      count = await _mediaBean.remove(media.id);
      if (count > 0) {
        _collectSubject.add(false);
      }
    }
    _adapter.close();
  }

  void _getCollect(int id) async {
    await initMediaBean();
    Media media = await _mediaBean.find(id);
    _collectSubject.add(media != null);
    _adapter.close();
  }

  Future initMediaBean() async {
    logger.fine('initMediaBean');
    _adapter = await SqfliteUtil().getAdapter();
    _mediaBean = MediaBean(_adapter);
    _mediaBean.initTable();
  }

  void _getCredits(Media media) async {
    List<Cast> cast = await ApiClientUtil()
        .getCredits(mediaType: media.mediaType, id: media.id);
    _castListSubject.add(cast.map((cast) {
      if (cast.profilePath != null) {
        cast.profilePath = PROFILE_IMAGE_URL_MEDIUM + cast.profilePath;
      }
      return cast;
    }).toList());
  }

  void _getMediaDetail(Media media) async {
    MediaDetail mediaDetail = await ApiClientUtil()
        .getMediaDetail(mediaType: media.mediaType, id: media.id);
    _mediaDetailSubject.add(mediaDetail);
  }

  void _getSimilarList(Media media) async {
    List<Media> similarList = await ApiClientUtil()
        .getSimilarList(mediaType: media.mediaType, id: media.id);
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
      MediaListRes res = await ApiClientUtil()
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

  void getCollectionMediaList([_]) async {
    SqfliteUtil sqfliteUtil = SqfliteUtil();
    SqfliteAdapter adapter = await sqfliteUtil.getAdapter();
    MediaBean mediaBean = MediaBean(adapter);
    List<Media> list = await mediaBean.queryAll();
    list = list.map((media) {
      List<dynamic> genreIds = media.genreIdsJson != null
          ? JsonDecoder().convert(media.genreIdsJson).toList()
          : [];
//      logger.fine('genreIds--${genreIds.map((genreId) => int.parse(genreId.toString())).toList()}');
      return media
        ..genreIds =
            genreIds.map((genreId) => int.parse(genreId.toString())).toList();
    }).toList();

    collectionMediaListState..list = list;
    logger.fine(
        'getCollectionMediaList--collectionMediaListState..list--${collectionMediaListState.list.toString()}');
    _collectMediaListSubject.add(collectionMediaListState);
  }

  void getMediaListAction({int len: 0}) {
    this.page.add(len);
  }

  void getCastListAction(Media media) {
    this.castListFromId.add(media);
  }

  void getMediaDetailAction(Media media) {
    logger.fine('getMediaDetailAction--media--${media.toString()}');
    this.mediaDetailFromMedia.add(media);
  }

  void getSimilarListAction(Media media) {
    this.similarListFromId.add(media);
  }

  void getCollectAction(int id) {
    this.getCollect.add(id);
  }

  void saveCollectAction(Media media) {
    logger.fine('saveCollectAction--media--${media.toString()}');
    this.saveCollect.add(media);
  }

  void getCollectionMediaListAction() {
    this._getCollectionMediaListController.add(Null);
  }

  void mediaSearchAction({String keyword, int len: 0}) {
    logger.fine('mediaSearchAction');
    if (len == 0) {
      _keyword = keyword;
    }
    Map<String, dynamic> params = {
      'keyword': _keyword,
      'len': len,
    };
    this._mediaSearchController.add(params);
  }
}

class MediaListState {
  List<Media> list;
}
