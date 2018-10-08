import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre {
  int id;
  String name;

  Genre();

  factory Genre.fromJsonText(String json) =>
      _$GenreFromJson(JsonDecoder().convert(json));

  factory Genre.fromJson(Map<String, dynamic> json) =>
      _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
