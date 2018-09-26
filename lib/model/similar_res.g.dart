// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimilarRes _$SimilarResFromJson(Map<String, dynamic> json) {
  return SimilarRes()
    ..page = json['page'] as int
    ..results = (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Media.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SimilarResToJson(SimilarRes instance) =>
    <String, dynamic>{'page': instance.page, 'results': instance.results};
