// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaDetail _$MediaDetailFromJson(Map<String, dynamic> json) {
  return MediaDetail()
    ..voteCount = json['vote_count'] as int
    ..id = json['id'] as int
    ..video = json['video'] as bool
    ..voteAverage = (json['vote_average'] as num)?.toDouble()
    ..title = json['title'] as String
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
    ..belongsToCollection = json['belongs_to_collection'] == null
        ? null
        : BelongsToCollection.fromJson(
            json['belongs_to_collection'] as Map<String, dynamic>)
    ..budget = json['budget'] as int
    ..genres = (json['genres'] as List)
        ?.map(
            (e) => e == null ? null : Genre.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..productionCompanies = (json['production_companies'] as List)
        ?.map((e) => e == null
            ? null
            : ProductionCompanie.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..productionCountries = (json['production_countries'] as List)
        ?.map((e) => e == null
            ? null
            : ProductionCountrie.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..spokenLanguages = (json['spoken_languages'] as List)
        ?.map((e) => e == null
            ? null
            : SpokenLanguage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..revenue = json['revenue'] as int
    ..runtime = json['runtime'] as int
    ..status = json['status'] as String
    ..tagline = json['tagline'] as String
    ..originalName = json['original_name'] as String
    ..homepage = json['homepage'] as String
    ..imdbId = json['imdb_id'] as String;
}

Map<String, dynamic> _$MediaDetailToJson(MediaDetail instance) =>
    <String, dynamic>{
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
      'release_date': instance.releaseDate?.toIso8601String(),
      'belongs_to_collection': instance.belongsToCollection,
      'budget': instance.budget,
      'genres': instance.genres,
      'production_companies': instance.productionCompanies,
      'production_countries': instance.productionCountries,
      'spoken_languages': instance.spokenLanguages,
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'status': instance.status,
      'tagline': instance.tagline,
      'original_name': instance.originalName,
      'homepage': instance.homepage,
      'imdb_id': instance.imdbId
    };
