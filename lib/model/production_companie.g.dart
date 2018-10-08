// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_companie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCompanie _$ProductionCompanieFromJson(Map<String, dynamic> json) {
  return ProductionCompanie()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..posterPath = json['poster_path'] as String
    ..backdropPath = json['backdrop_path'] as String;
}

Map<String, dynamic> _$ProductionCompanieToJson(ProductionCompanie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath
    };
