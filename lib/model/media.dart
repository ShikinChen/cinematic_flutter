import 'package:json_annotation/json_annotation.dart';
import 'package:cinematic_flutter/util/date_time_util.dart';

part 'media.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'vote_count')
  String voteCount;
  String id;
  String video;
  @JsonKey(name: 'vote_average')
  String voteAverage;
  String title;
  double popularity;
  @JsonKey(name: 'poster_path')
  String posterPath;
  @JsonKey(name: 'original_language')
  String originalLanguage;
  @JsonKey(name: 'original_title')
  String originalTitle;
  @JsonKey(name: 'genre_ids')
  List<String> genreIds;
  @JsonKey(name: 'backdrop_path')
  String backdropPath;
  bool adult;
  String overview;
  @JsonKey(name: 'release_date', fromJson: toDateTime)
  DateTime releaseDate;


  Movie();

  factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
