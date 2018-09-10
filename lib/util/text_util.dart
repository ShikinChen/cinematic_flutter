import 'package:cinematic_flutter/localizations.dart';
import 'package:flutter/material.dart';

Map<int, String> _genreMap(BuildContext ctx) => {
      28: AppLocalizations.of(ctx).action,
      12: AppLocalizations.of(ctx).adventure,
      16: AppLocalizations.of(ctx).animation,
      35: AppLocalizations.of(ctx).comedy,
      80: AppLocalizations.of(ctx).crime,
      99: AppLocalizations.of(ctx).documentary,
      18: AppLocalizations.of(ctx).drama,
      10751: AppLocalizations.of(ctx).family,
      10762: AppLocalizations.of(ctx).kids,
      10759: AppLocalizations.of(ctx).actionAdventure,
      14: AppLocalizations.of(ctx).fantasy,
      36: AppLocalizations.of(ctx).history,
      27: AppLocalizations.of(ctx).horror,
      10402: AppLocalizations.of(ctx).music,
      9648: AppLocalizations.of(ctx).mystery,
      10749: AppLocalizations.of(ctx).romance,
      878: AppLocalizations.of(ctx).scienceFiction,
      10770: AppLocalizations.of(ctx).tvMovie,
      53: AppLocalizations.of(ctx).thriller,
      10752: AppLocalizations.of(ctx).war,
      37: AppLocalizations.of(ctx).western,
      10763: '',
      10764: AppLocalizations.of(ctx).reality,
      10765: AppLocalizations.of(ctx).sciFiFantasy,
      10766: AppLocalizations.of(ctx).soap,
      10767: AppLocalizations.of(ctx).talk,
      10768: AppLocalizations.of(ctx).warPolitics,
    };

List<String> getGenresForIds(List<int> genreIds, BuildContext ctx) =>
    genreIds.map((id) => _genreMap(ctx)[id]).toList();

String getGenreString(List<int> genreIds, BuildContext ctx) {
  StringBuffer buffer = StringBuffer();
  buffer.writeAll(getGenresForIds(genreIds, ctx), ", ");
  return buffer.toString();
}
