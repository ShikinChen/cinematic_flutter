// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_list_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreListRes _$GenreListResFromJson(Map<String, dynamic> json) {
  return GenreListRes()
    ..genres = (json['genres'] as List)
        ?.map(
            (e) => e == null ? null : Genre.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GenreListResToJson(GenreListRes instance) =>
    <String, dynamic>{'genres': instance.genres};
