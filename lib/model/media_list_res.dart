import 'dart:convert';

import 'package:cinematic_flutter/model/media.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cinematic_flutter/util/date_time_util.dart';

part 'media_list_res.g.dart';

@JsonSerializable()
class MediaListRes {
  int page;
  @JsonKey(name: 'total_results')
  int totalResults;
  @JsonKey(name: 'total_pages')
  int totalPages;
  List<Media> results;

  MediaListRes({this.page: -1});

  factory MediaListRes.fromJsonText(String json) =>
      _$MediaListResFromJson(JsonDecoder().convert(json));

  factory MediaListRes.fromJson(Map<String, dynamic> json) =>
      _$MediaListResFromJson(json);

  Map<String, dynamic> toJson() => _$MediaListResToJson(this);
}
