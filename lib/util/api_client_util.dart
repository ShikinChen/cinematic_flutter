import 'dart:async';
import 'dart:io';

import 'package:cinematic_flutter/model/cast.dart';
import 'package:cinematic_flutter/model/credits_res.dart';
import 'package:cinematic_flutter/model/genre.dart';
import 'package:cinematic_flutter/model/genre_list_res.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/media_detail.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:cinematic_flutter/model/similar_res.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/model/media_category.dart';
import 'package:dio/dio.dart';
import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/media_list_res.dart';
import 'package:logging/logging.dart';

class ApiClientUtil {
  final paging = 20;
  final Logger logger = Logger('ApiClient');
  static final ApiClientUtil _singleton = new ApiClientUtil._internal();
  final Dio _dio = Dio(new Options(
    baseUrl: "http://api.themoviedb.org/3",
    connectTimeout: 30000,
    receiveTimeout: 30000,
  ));
  String language;
  MediaType mediaType = MediaType.movie;

  factory ApiClientUtil() {
    _singleton._dio.interceptor.request.onSend = (Options options) {
      Map<String, dynamic> data = {
        'api_key': API_KEY,
        'language': _singleton.language,
      };
      options.data = options.data ?? Map();
      if (options.data != null) {
        data.addAll(options.data);
      }
      _singleton.logger.fine('request--${options.data}');
      return options..data = data;
    };
    _singleton._dio.interceptor.response.onSuccess = (Response response) {
      _singleton.logger.fine('response--${response.data.toString()}');
      return response;
    };
    _singleton._dio.interceptor.response.onError = (DioError e) {
      _singleton.logger.fine('error--${e.message}');
      return e;
    };
    _singleton._dio.onHttpClientCreate = (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 10.48.78.152:8888";
      };
    };
    return _singleton;
  }

  int getPage([int len = 0]) {
    int page = len ~/ paging;
    page++;
    return len % paging == 0 ? page : page + 1;
  }

  Dio get dio => _dio;

  ApiClientUtil._internal();

  Future<MediaListRes> getMovieList(
      {@required MediaCategory mediaCategory, int len = 1}) {
    String mediaTypeText = getMediaTypeName(mediaType);
    String mediaCategoryText = getMediaCategoryName(mediaCategory);
    return _dio.get(
      "/${mediaTypeText}/${mediaCategoryText}",
      data: {'page': getPage(len)},
    ).then((res) {
      if (res.statusCode == 200) {
        return MediaListRes.fromJson(res.data);
      } else {
        return MediaListRes();
      }
    });
  }

  Future<List<Genre>> getGenreList(
      {@required MediaType mediaType, @required String language}) {
    return _dio.get("/genre/${getMediaTypeName(mediaType)}/list", data: {
      'language': language,
    }).then((res) {
      if (res.statusCode == 200) {
        return GenreListRes.fromJson(res.data).genres;
      } else {
        return List();
      }
    });
  }

  Future<List<Cast>> getCredits(
      {@required String mediaType, @required int id}) {
    if (mediaType == null) {
      mediaType = getMediaTypeName(this.mediaType);
    }
    return _dio.get("/${mediaType}/${id}/credits", data: {
      'language': language,
    }).then((res) {
      if (res.statusCode == 200) {
        return CreditsRes.fromJson(res.data).cast;
      } else {
        return List();
      }
    });
  }

  Future<MediaDetail> getMediaDetail(
      {@required String mediaType, @required int id}) {
    logger.fine('getMediaDetail--mediaType--${mediaType}');
    if (mediaType == null) {
      mediaType = getMediaTypeName(this.mediaType);
    }
    return _dio.get("/${mediaType}/${id}", data: {
      'language': language,
    }).then((res) {
      if (res.statusCode == 200) {
        return MediaDetail.fromJson(res.data);
      } else {
        return MediaDetail();
      }
    });
  }

  Future<List<Media>> getSimilarList(
      {@required String mediaType, @required int id, int page: 1}) {
    if (mediaType == null) {
      mediaType = getMediaTypeName(this.mediaType);
    }
    return _dio.get("/${mediaType}/${id}/similar", data: {
      'page': page,
      'language': language,
    }).then((res) {
      if (res.statusCode == 200) {
        return SimilarRes.fromJson(res.data).results;
      } else {
        return List();
      }
    });
  }
}
