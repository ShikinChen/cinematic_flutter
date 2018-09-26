import 'dart:convert';

import 'package:cinematic_flutter/model/genre.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cinematic_flutter/util/date_time_util.dart';

part 'genre_list_res.g.dart';

@JsonSerializable()
class GenreListRes {
  List<Genre> genres;

  GenreListRes();

  factory GenreListRes.fromJsonText(String json) =>
      _$GenreListResFromJson(JsonDecoder().convert(json));

  factory GenreListRes.fromJson(Map<String, dynamic> json) =>
      _$GenreListResFromJson(json);

  Map<String, dynamic> toJson() => _$GenreListResToJson(this);
}
