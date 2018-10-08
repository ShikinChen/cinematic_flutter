import 'dart:convert';

import 'package:cinematic_flutter/model/cast.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credits_res.g.dart';

@JsonSerializable()
class CreditsRes {
  int id;
  List<Cast> cast;

  CreditsRes();

  factory CreditsRes.fromJsonText(String json) =>
      _$CreditsResFromJson(JsonDecoder().convert(json));

  factory CreditsRes.fromJson(Map<String, dynamic> json) =>
      _$CreditsResFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsResToJson(this);
}
