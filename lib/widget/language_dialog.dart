import 'package:flutter/material.dart';
import 'package:cinematic_flutter/common/app_localizations.dart';

class LanguageDialog {
  static SimpleDialog of(BuildContext ctx) {
    Text title = Text(AppLocalizations.of(ctx).text(''));
    return SimpleDialog(
      title: title,
    );
  }
}
