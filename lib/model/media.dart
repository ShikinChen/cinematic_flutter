import 'package:json_annotation/json_annotation.dart';
import 'package:cinematic_flutter/util/date_time_util.dart';

part 'media.g.dart';

@JsonSerializable()
class Media {
  @JsonKey(name: 'vote_count')
  int voteCount;
  int id;
  bool video;
  @JsonKey(name: 'vote_average')
  double voteAverage;
  String title;
  double popularity;
  @JsonKey(name: 'poster_path')
  String posterPath;
  @JsonKey(name: 'original_language')
  String originalLanguage;
  @JsonKey(name: 'original_title')
  String originalTitle;
  @JsonKey(name: 'genre_ids')
  List<int> genreIds;
  @JsonKey(name: 'backdrop_path')
  String backdropPath;
  bool adult;
  String overview;
  @JsonKey(name: 'release_date', fromJson: toDateTime)
  DateTime releaseDate;

  Media();

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
