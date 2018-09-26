import 'dart:convert';

import 'package:cinematic_flutter/model/cast.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'similar_res.g.dart';

@JsonSerializable()
class SimilarRes {
  int page;
  List<Media> results;

  SimilarRes();

  factory SimilarRes.fromJsonText(String json) =>
      _$SimilarResFromJson(JsonDecoder().convert(json));

  factory SimilarRes.fromJson(Map<String, dynamic> json) =>
      _$SimilarResFromJson(json);

  Map<String, dynamic> toJson() => _$SimilarResToJson(this);
}
