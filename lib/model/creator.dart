import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'creator.g.dart';

@JsonSerializable()
class Creator {
  int id;
  @JsonKey(name: 'credit_id')
  String creditId;
  String name;
  int gender;
  @JsonKey(name: 'profile_path')
  String profilePath;

  Creator();

  factory Creator.fromJsonText(String json) =>
      _$CreatorFromJson(JsonDecoder().convert(json));

  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorToJson(this);
}
