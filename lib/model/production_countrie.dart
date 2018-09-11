import 'package:json_annotation/json_annotation.dart';

part 'production_countrie.g.dart';

@JsonSerializable()
class ProductionCountrie {
  @JsonKey(name: 'iso_3166_1')
  String iso31661;
  String name;

  ProductionCountrie();

  factory ProductionCountrie.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountrieFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountrieToJson(this);
}
