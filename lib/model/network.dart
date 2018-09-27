import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'network.g.dart';

@JsonSerializable()
class Network {
  int id;
  @JsonKey(name: 'logo_path')
  String logoPath;
  String name;
  @JsonKey(name: 'origin_country')
  String originCountry;

  Network();

  factory Network.fromJsonText(String json) =>
      _$NetworkFromJson(JsonDecoder().convert(json));

  factory Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkToJson(this);
}
