import 'dart:async';

import 'package:cinematic_flutter/util/api_client_util.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:cinematic_flutter/l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/model/app_locale.dart';
import 'package:logging/logging.dart';

class AppLocalizations {
  static const String EN = 'en';
  static const String ZH = 'zh';
  static const AppLocale EN_LOCALE = AppLocale('en-US', Locale(EN, ""));
  static const AppLocale ZH_LOCALE = AppLocale('zh', Locale(ZH, ""));

  static Future<AppLocalizations> load(Locale locale) {
    if (locale != null) {
      Logger logger = Logger('AppLocalizations');
      final String name =
          locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
      final String localeName = Intl.canonicalizedLocale(name);
      logger.fine('locale.languageCode--${locale.languageCode}');
      if (locale.languageCode.contains(EN)) {
        ApiClientUtil().language = EN;
      } else {
        ApiClientUtil().language = ZH;
      }

      return initializeMessages(localeName).then((bool _) {
        Intl.defaultLocale = localeName;
        return new AppLocalizations();
      });
    }
    return null;
  }

  static AppLocale getLocale(String localeName) {
    switch (localeName) {
      case EN:
        {
          return EN_LOCALE;
        }
      case ZH:
        {
          return ZH_LOCALE;
        }
      default:
        return null;
    }
  }

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  String get appTitle => Intl.message(
        'Cinematic',
        name: 'appTitle',
        args: [],
      );

  String get search => Intl.message(
        'Search',
        name: 'search',
        args: [],
      );

  String get favorites => Intl.message(
        'Favorites',
        name: 'favorites',
        args: [],
      );

  String get movies => Intl.message(
        'Movies',
        name: 'movies',
        args: [],
      );

  String get tvShows => Intl.message(
        'TV Shows',
        name: 'tvShows',
        args: [],
      );

  String get language => Intl.message(
        'Language',
        name: 'language',
        args: [],
      );

  String get english => Intl.message(
        'English',
        name: 'english',
        args: [],
      );

  String get simplifiedChinese => Intl.message(
        'Simplified Chinese',
        name: 'simplifiedChinese',
        args: [],
      );

  String get popular => Intl.message(
        'Popular',
        name: 'popular',
        args: [],
      );

  String get upcoming => Intl.message(
        'Upcoming',
        name: 'upcoming',
        args: [],
      );

  String get topRated => Intl.message(
        'Top Rated',
        name: 'topRated',
        args: [],
      );

  String get onTheAir => Intl.message(
        'On The Air',
        name: 'onTheAir',
        args: [],
      );

  String get action => Intl.message(
        'Action',
        name: 'action',
        args: [],
      );

  String get adventure => Intl.message(
        'Adventure',
        name: 'adventure',
        args: [],
      );

  String get animation => Intl.message(
        'Animation',
        name: 'animation',
        args: [],
      );

  String get comedy => Intl.message(
        'Comedy',
        name: 'comedy',
        args: [],
      );

  String get crime => Intl.message(
        'Crime',
        name: 'crime',
        args: [],
      );

  String get documentary => Intl.message(
        'Documentary',
        name: 'documentary',
        args: [],
      );

  String get drama => Intl.message(
        'Drama',
        name: 'drama',
        args: [],
      );

  String get family => Intl.message(
        'Family',
        name: 'family',
        args: [],
      );

  String get kids => Intl.message(
        'Kids',
        name: 'kids',
        args: [],
      );

  String get actionAdventure => Intl.message(
        'Action & Adventure',
        name: 'actionAdventure',
        args: [],
      );

  String get fantasy => Intl.message(
        'Fantasy',
        name: 'fantasy',
        args: [],
      );

  String get history => Intl.message(
        'History',
        name: 'history',
        args: [],
      );

  String get horror => Intl.message(
        'Horror',
        name: 'horror',
        args: [],
      );

  String get music => Intl.message(
        'Music',
        name: 'music',
        args: [],
      );

  String get mystery => Intl.message(
        'Mystery',
        name: 'mystery',
        args: [],
      );

  String get romance => Intl.message(
        'Romance',
        name: 'romance',
        args: [],
      );

  String get scienceFiction => Intl.message(
        'Science Fiction',
        name: 'scienceFiction',
        args: [],
      );

  String get tvMovie => Intl.message(
        'TV Movie',
        name: 'tvMovie',
        args: [],
      );

  String get thriller => Intl.message(
        'Thriller',
        name: 'thriller',
        args: [],
      );

  String get war => Intl.message(
        'War',
        name: 'war',
        args: [],
      );

  String get western => Intl.message(
        'Western',
        name: 'western',
        args: [],
      );

  String get reality => Intl.message(
        'Reality',
        name: 'reality',
        args: [],
      );

  String get sciFiFantasy => Intl.message(
        'Sci-Fi & Fantasy',
        name: 'sciFiFantasy',
        args: [],
      );

  String get soap => Intl.message(
        'Soap',
        name: 'soap',
        args: [],
      );

  String get talk => Intl.message(
        'Talk',
        name: 'talk',
        args: [],
      );

  String get warPolitics => Intl.message(
        'War & Politics',
        name: 'warPolitics',
        args: [],
      );

  String get synopsis => Intl.message(
        'SYNOPSIS',
        name: 'synopsis',
        args: [],
      );

  String get cast => Intl.message(
        'Cast',
        name: 'cast',
        args: [],
      );

  String get about => Intl.message(
        'About',
        name: 'about',
        args: [],
      );

  String get originalTitle => Intl.message(
        'Original Title',
        name: 'originalTitle',
        args: [],
      );

  String get status => Intl.message(
        'Status',
        name: 'status',
        args: [],
      );

  String get runtime => Intl.message(
        'Runtime',
        name: 'runtime',
        args: [],
      );

  String get type => Intl.message(
        'Type',
        name: 'type',
        args: [],
      );

  String get creators => Intl.message(
        'Creators',
        name: 'creators',
        args: [],
      );

  String get networks => Intl.message(
        'Networks',
        name: 'networks',
        args: [],
      );

  String get seasons => Intl.message(
        'Seasons',
        name: 'seasons',
        args: [],
      );

  String get premiere => Intl.message(
        'Premiere',
        name: 'premiere',
        args: [],
      );

  String get latest_next_episode => Intl.message(
        'Latest/Next Episode',
        name: 'latest_next_episode',
        args: [],
      );

  String get budget => Intl.message(
        'Budget',
        name: 'budget',
        args: [],
      );

  String get revenue => Intl.message(
        'Revenue',
        name: 'revenue',
        args: [],
      );

  String get homepage => Intl.message(
        'Homepage',
        name: 'homepage',
        args: [],
      );

  String get imdb => Intl.message(
        'Imdb',
        name: 'imdb',
        args: [],
      );

  String get similar => Intl.message(
        'Similar',
        name: 'similar',
        args: [],
      );

  String seasonsEpisodes(int numberOfSeasons, int numberOfEpisodes) =>
      Intl.message(
        '$numberOfSeasons Seasons and $numberOfEpisodes Episodes',
        name: 'seasonsEpisodes',
        args: [numberOfSeasons, numberOfEpisodes],
      );
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) =>
      [AppLocalizations.EN, AppLocalizations.ZH].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
