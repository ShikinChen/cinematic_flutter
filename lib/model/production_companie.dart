import 'package:json_annotation/json_annotation.dart';

part 'production_companie.g.dart';

@JsonSerializable()
class ProductionCompanie {
  int id;
  String name;
  @JsonKey(name: 'poster_path')
  String posterPath;
  @JsonKey(name: 'backdrop_path')
  String backdropPath;

  ProductionCompanie();

  factory ProductionCompanie.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanieFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanieToJson(this);
}
