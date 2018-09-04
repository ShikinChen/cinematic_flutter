import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:cinematic_flutter/common/messages_all.dart';
import 'package:cinematic_flutter/common/localizations_keys.dart';

class AppLocalizations {
  final Locale locale;

  const AppLocalizations(this.locale);

  static Future<AppLocalizations> load(Locale locale) =>
      initializeMessage(locale.toString()).then(
        (_) => AppLocalizations(locale),
      );

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  String get appTitle => Intl.message(
        'Cinematic',
        name: LocalizationsKeys.APP_TITLE_KEY,
        args: [],
        locale: locale.toString(),
      );

  String text(String key) => Intl.message(
        key.toLowerCase().replaceAll('_', ' '),
        name: key,
        args: [],
        locale: locale.toString(),
      );
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains(LocalizationsKeys.EN_KEY);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
