import 'package:cinematic_flutter/model/creator.dart';
import 'package:cinematic_flutter/model/genre.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/network.dart';
import 'package:cinematic_flutter/model/production_countrie.dart';
import 'package:cinematic_flutter/model/spoken_language.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cinematic_flutter/util/date_time_util.dart';
import 'package:cinematic_flutter/model/belongs_to_collection.dart';
import 'package:cinematic_flutter/model/production_companie.dart';

part 'media_detail.g.dart';

@JsonSerializable()
class MediaDetail extends Media {
  @JsonKey(name: 'belongs_to_collection')
  BelongsToCollection belongsToCollection;
  int budget;

  List<Genre> genres;
  @JsonKey(name: 'production_companies')
  List<ProductionCompanie> productionCompanies;
  @JsonKey(name: 'production_countries')
  List<ProductionCountrie> productionCountries;
  @JsonKey(name: 'spoken_languages')
  List<SpokenLanguage> spokenLanguages;
  int revenue;
  int runtime;
  String status;
  String tagline;
  @JsonKey(name: 'original_name')
  String originalName;

  String homepage;
  @JsonKey(name: 'imdb_id')
  String imdbId;

  @JsonKey(name: 'created_by')
  List<Creator> creator;

  @JsonKey(name: 'networks')
  List<Network> networks;

  @JsonKey(name: 'number_of_seasons')
  int numberOfSeasons;
  @JsonKey(name: 'number_of_episodes')
  int numberOfEpisodes;

  MediaDetail();

  factory MediaDetail.fromJson(Map<String, dynamic> json) =>
      _$MediaDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDetailToJson(this);
}
