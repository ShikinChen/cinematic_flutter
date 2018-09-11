import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/model/cast.dart';
import 'package:cinematic_flutter/widget/cast_card.dart';
import 'package:flutter/material.dart';

class CastSection extends StatelessWidget {
  final List<Cast> castList;

  CastSection(this.castList);

  @override
  Widget build(BuildContext context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations
              .of(context)
              .cast),
          Container(
            height: 8.0,
          ),
          Container(
            height: 140.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: castList.map(
                    (cast) =>
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CastCard(cast),
                    ),
              ).toList(),
            ),
          ),
        ],
      );
}
