// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_list_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaListRes _$MediaListResFromJson(Map<String, dynamic> json) {
  return MediaListRes(page: json['page'] as int)
    ..totalResults = json['total_results'] as int
    ..totalPages = json['total_pages'] as int
    ..results = (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Media.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MediaListResToJson(MediaListRes instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
      'results': instance.results
    };
