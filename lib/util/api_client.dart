import 'dart:async';
import 'dart:io';

import 'package:cinematic_flutter/model/media.dart';
import 'package:dio/dio.dart';
import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/model/media_list_res.dart';
import 'package:logging/logging.dart';

class ApiClient {
  final Logger logger = Logger('ApiClient');
  static final ApiClient _singleton = new ApiClient._internal();
  final Dio _dio = Dio(new Options(
    baseUrl: "http://api.themoviedb.org/3",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));
  String language;

  factory ApiClient() {
    _singleton._dio.interceptor.request.onSend = (Options options) {
      _singleton.logger.fine('request--${options.data}');
      Map<String, dynamic> data = {
        'api_key': API_KEY,
        'language': _singleton.language,
      };
      if (options.data != null) {
        data.addAll(options.data);
      }
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

  Dio get dio => _dio;

  ApiClient._internal();

  Future<MediaListRes> getMovieList({int page = 1}) {
    return _dio.get(
      "/movie/popular",
      data: {'page': page.toString()},
    ).then((res) {
      if (res.statusCode == 200) {
        return MediaListRes.fromJson(res.data);
      } else {
        return MediaListRes();
      }
    });
  }
}
