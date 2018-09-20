import 'package:cinematic_flutter/model/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/viewmodel/home_view_model.dart';

class LanguageDialog {
  static SimpleDialog of(BuildContext ctx, HomeViewModel vm) {
    Text title = Text(AppLocalizations.of(ctx).language);
    return SimpleDialog(
      title: title,
      children: buildSimpleDialogOption(ctx, vm),
    );
  }

  static List<Widget> buildSimpleDialogOption(
      BuildContext ctx, HomeViewModel vm) {
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
                vm.loadLocale(item.locale);
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
