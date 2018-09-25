import 'package:cinematic_flutter/model/app_locale.dart';
import 'package:cinematic_flutter/provider/app_state_provider.dart';
import 'package:cinematic_flutter/provider/media_provider.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/localizations.dart';

class LanguageDialog {
  static SimpleDialog of(BuildContext ctx) {
    Text title = Text(AppLocalizations.of(ctx).language);
    return SimpleDialog(
      title: title,
      children: buildSimpleDialogOption(ctx),
    );
  }

  static List<Widget> buildSimpleDialogOption(BuildContext ctx) {
    final appStateBloc = AppStateProvider.of(ctx);
    final mediaBloc = MediaProvider.of(ctx);
    return [
      LocaleItem(
        AppLocalizations.of(ctx).simplifiedChinese,
        AppLocalizations.ZH_LOCALE,
      ),
      LocaleItem(
        AppLocalizations.of(ctx).english,
        AppLocalizations.EN_LOCALE,
      ),
    ]
        .map((item) => new SimpleDialogOption(
              onPressed: () {
                appStateBloc.loadLocaleAction(item.locale, () {
                  mediaBloc.getMediaListAction(len: -1);
                });
                Navigator.pop(ctx);
              },
              child: Text(item.text),
            ))
        .toList();
  }
}

class LocaleItem {
  String text;
  AppLocale locale;

  LocaleItem(this.text, this.locale);
}
