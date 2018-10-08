import 'package:flutter/material.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/common/navigator.dart';
import 'package:logging/logging.dart';

class SimilarSection extends StatelessWidget {
  final List<Media> list;
  Logger logging = Logger('SimilarSection');

  SimilarSection(this.list);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(AppLocalizations.of(context).similar),
          ),
          Container(
            height: 300.0,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              scrollDirection: Axis.horizontal,
              children: list
                  .map((media) => GestureDetector(
                        onTap: () => goToMediaDetail(context, media),
                        child: media.posterPath == null
                            ? Image.asset(
                                'assets/images/placeholder.jpg',
                                height: 150.0,
                                fit: BoxFit.cover,
                              )
                            : FadeInImage.assetNetwork(
                                placeholder: 'assets/images/placeholder.jpg',
                                image: media.posterPath,
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                      ))
                  .toList(),
            ),
          ),
        ],
      );
}
