import 'package:cinematic_flutter/model/media_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cinematic_flutter/util/date_time_util.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'media.g.dart';

@JsonSerializable()
class Media {
  @JsonKey(name: 'vote_count')
  @Column(isNullable: true)
  int voteCount;
  @PrimaryKey()
  int id;
  @Column(isNullable: true)
  bool video;
  @JsonKey(name: 'vote_average')
  @Column(isNullable: true)
  double voteAverage;
  @Column(isNullable: true)
  String title;
  @Column(isNullable: true)
  String name;
  @Column(isNullable: true)
  double popularity;
  @JsonKey(name: 'poster_path')
  @Column(isNullable: true)
  String posterPath;
  @JsonKey(name: 'original_language')
  @Column(isNullable: true)
  String originalLanguage;
  @JsonKey(name: 'original_title')
  @Column(isNullable: true)
  String originalTitle;
  @JsonKey(name: 'genre_ids')
  @IgnoreColumn()
  List<int> genreIds;
  @JsonKey(name: 'backdrop_path')
  @Column(isNullable: true)
  String backdropPath;
  @Column(isNullable: true)
  bool adult;
  @Column(isNullable: true)
  String overview;
  @JsonKey(name: 'release_date', fromJson: toDateTime)
  @Column(isNullable: true)
  DateTime releaseDate;
  @JsonKey(name: 'first_air_date', fromJson: toDateTime)
  @Column(isNullable: true)
  DateTime firstAirDate;
  @Column(isNullable: true)
  String genreIdsJson;

  @Column(isNullable: true)
  String mediaType;

  Media();

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);

  @override
  String toString() {
    return 'Media{voteCount: $voteCount, id: $id, video: $video, voteAverage: $voteAverage, title: $title, name: $name, popularity: $popularity, posterPath: $posterPath, originalLanguage: $originalLanguage, originalTitle: $originalTitle, genreIds: $genreIds, backdropPath: $backdropPath, adult: $adult, overview: $overview, releaseDate: $releaseDate, firstAirDate: $firstAirDate, genreIdsJson: $genreIdsJson, mediaType: $mediaType}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Media &&
          runtimeType == other.runtimeType &&
          voteCount == other.voteCount &&
          id == other.id &&
          video == other.video &&
          voteAverage == other.voteAverage &&
          title == other.title &&
          name == other.name &&
          popularity == other.popularity &&
          posterPath == other.posterPath &&
          originalLanguage == other.originalLanguage &&
          originalTitle == other.originalTitle &&
          genreIds == other.genreIds &&
          backdropPath == other.backdropPath &&
          adult == other.adult &&
          overview == other.overview &&
          releaseDate == other.releaseDate &&
          firstAirDate == other.firstAirDate &&
          genreIdsJson == other.genreIdsJson;

  @override
  int get hashCode =>
      voteCount.hashCode ^
      id.hashCode ^
      video.hashCode ^
      voteAverage.hashCode ^
      title.hashCode ^
      name.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      genreIds.hashCode ^
      backdropPath.hashCode ^
      adult.hashCode ^
      overview.hashCode ^
      releaseDate.hashCode ^
      firstAirDate.hashCode ^
      genreIdsJson.hashCode;

  String get tag => 'media_tag_${hashCode}';
}
