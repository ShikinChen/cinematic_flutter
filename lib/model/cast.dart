import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'cast.g.dart';

@JsonSerializable()
class Cast {
  int cast_id;
  String character;
  @JsonKey(name: 'credit_id')
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  @JsonKey(name: 'profile_path')
  String profilePath;

  Cast();

  factory Cast.fromJsonText(String json) =>
      _$CastFromJson(JsonDecoder().convert(json));

  factory Cast.fromJsonMap(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}
