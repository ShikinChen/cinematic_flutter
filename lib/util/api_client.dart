import 'dart:async';
import 'dart:io';

import 'package:cinematic_flutter/model/media_type.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/model/media_category.dart';
import 'package:dio/dio.dart';
import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/media_list_res.dart';
import 'package:logging/logging.dart';

class ApiClient {
  final paging = 20;
  final Logger logger = Logger('ApiClient');
  static final ApiClient _singleton = new ApiClient._internal();
  final Dio _dio = Dio(new Options(
    baseUrl: "http://api.themoviedb.org/3",
    connectTimeout: 10000,
    receiveTimeout: 3000,
  ));
  String language;

  factory ApiClient() {
    _singleton._dio.interceptor.request.onSend = (Options options) {
      Map<String, dynamic> data = {
        'api_key': API_KEY,
        'language': _singleton.language,
      };
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

  ApiClient._internal();

  Future<MediaListRes> getMovieList(
      {@required MediaType mediaType,
      @required MediaCategory mediaCategory,
      int len = 1}) {
    String mediaTypeText = mediaType.toString().replaceAll('MediaType.', '');
    String mediaCategoryText =
        mediaCategory.toString().replaceAll('MediaCategory.', '');
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
}
