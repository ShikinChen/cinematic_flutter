import 'package:cinematic_flutter/common/navigator.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/util/text_util.dart';

class MediaListItem extends StatelessWidget {
  final Media media;

  MediaListItem(this.media);

  Widget _getTitleSection(BuildContext ctx) {
    String year = '';
    if (media.releaseDate != null) {
      year = media.releaseDate.year.toString();
    } else if (media.firstAirDate != null) {
      year = media.firstAirDate.year.toString();
    }
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    media.title ?? media.name,
                    style: Theme.of(ctx).textTheme.subhead.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    getGenreString(media.genreIds, ctx),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(ctx).textTheme.body1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    media.voteAverage.toString(),
                    style: Theme.of(ctx).textTheme.body1,
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Icon(
                    Icons.star,
                    size: 16.0,
                  ),
                ],
              ),
              Container(
                width: 4.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    year,
                    style: Theme.of(ctx).textTheme.body1,
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Icon(
                    Icons.date_range,
                    size: 16.0,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: () => goToMediaDetail(context, media),
          child: Column(
            children: <Widget>[
              Hero(
                tag: media.tag,
                child: media.backdropPath == null || media.posterPath == null
                    ? Image.asset('assets/images/placeholder.jpg')
                    : FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.jpg',
                        image: media.backdropPath ?? media.posterPath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 200.0,
                        fadeInDuration: Duration(milliseconds: 50),
                      ),
              ),
              _getTitleSection(context),
            ],
          ),
        ),
      );
}
