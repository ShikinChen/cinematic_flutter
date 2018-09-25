// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) {
  return Media()
    ..voteCount = json['vote_count'] as int
    ..id = json['id'] as int
    ..video = json['video'] as bool
    ..voteAverage = (json['vote_average'] as num)?.toDouble()
    ..title = json['title'] as String
    ..name = json['name'] as String
    ..popularity = (json['popularity'] as num)?.toDouble()
    ..posterPath = json['poster_path'] as String
    ..originalLanguage = json['original_language'] as String
    ..originalTitle = json['original_title'] as String
    ..genreIds = (json['genre_ids'] as List)?.map((e) => e as int)?.toList()
    ..backdropPath = json['backdrop_path'] as String
    ..adult = json['adult'] as bool
    ..overview = json['overview'] as String
    ..releaseDate = json['release_date'] == null
        ? null
        : toDateTime(json['release_date'] as String)
    ..firstAirDate = json['first_air_date'] == null
        ? null
        : toDateTime(json['first_air_date'] as String);
}

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'vote_count': instance.voteCount,
      'id': instance.id,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'title': instance.title,
      'name': instance.name,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'genre_ids': instance.genreIds,
      'backdrop_path': instance.backdropPath,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.releaseDate?.toIso8601String(),
      'first_air_date': instance.firstAirDate?.toIso8601String()
    };
