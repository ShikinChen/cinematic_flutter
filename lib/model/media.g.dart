// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie()
    ..voteCount = json['vote_count'] as String
    ..id = json['id'] as String
    ..video = json['video'] as String
    ..voteAverage = json['vote_average'] as String
    ..title = json['title'] as String
    ..popularity = (json['popularity'] as num)?.toDouble()
    ..posterPath = json['poster_path'] as String
    ..originalLanguage = json['original_language'] as String
    ..originalTitle = json['original_title'] as String
    ..genreIds = (json['genre_ids'] as List)?.map((e) => e as String)?.toList()
    ..backdropPath = json['backdrop_path'] as String
    ..adult = json['adult'] as bool
    ..overview = json['overview'] as String
    ..releaseDate = json['release_date'] == null
        ? null
        : toDateTime(json['release_date'] as String);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'vote_count': instance.voteCount,
      'id': instance.id,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'title': instance.title,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'genre_ids': instance.genreIds,
      'backdrop_path': instance.backdropPath,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.releaseDate?.toIso8601String()
    };
