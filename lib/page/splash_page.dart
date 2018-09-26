import 'package:flutter/material.dart';
import 'package:cinematic_flutter/localizations.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => Scaffold(
        body: Container(
          child: Center(
            child: Text(AppLocalizations.of(ctx).appTitle),
          ),
        ),
      );
}
