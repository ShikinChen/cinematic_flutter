import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:cinematic_flutter/l10n/messages_all.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  static const String EN = 'en';
  static const String ZH = 'zh';
  static const Locale EN_LOCALE = Locale(EN, "");
  static const Locale ZH_LOCALE = Locale(ZH, "");

  static Future<AppLocalizations> load(Locale locale) {
    if (locale != null) {
      final String name =
          locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
      final String localeName = Intl.canonicalizedLocale(name);

      return initializeMessages(localeName).then((bool _) {
        Intl.defaultLocale = localeName;
        return new AppLocalizations();
      });
    }
    return null;
  }

  static Locale getLocale(String localeName) {
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
