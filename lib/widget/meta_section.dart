import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/model/media_detail.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/util/text_util.dart';

class MetaSection extends StatelessWidget {
  final MediaDetail mediaDetail;

  MetaSection(this.mediaDetail);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).about,
          ),
          Container(
            height: 8.0,
          ),
          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).originalTitle,
            mediaDetail.originalTitle,
          ),
          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).originalTitle,
            mediaDetail.originalName,
          ),
          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).status,
            mediaDetail.status,
          ),
          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).runtime,
            formatRuntime(mediaDetail.runtime),
          ),
          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).type,
            mediaDetail.genres.map((genre) => genre.name).toList().join(','),
          ),
//          _getMetaInfoSection(
//            context,
//            AppLocalizations.of(context).creators,
//         mediaDetail.cre,
//          ),

//          _getMetaInfoSection(
//            context,
//            AppLocalizations.of(context).networks,
//            mediaDetail.ne,
//          ),

//          _getMetaInfoSection(
//            context,
//            AppLocalizations.of(context).seasons,
//            mediaDetail.genres.map((genre) => genre.name).toList().join(','),
//          ),

          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).premiere,
            formatDate(mediaDetail.releaseDate),
          ),
//          _getMetaInfoSection(
//            context,
//            AppLocalizations.of(context).premiere,
//            formatDate(mediaDetail.fi),
//          ),

//          _getMetaInfoSection(
//            context,
//            AppLocalizations.of(context).latest_next_episode,
//            formatDate(mediaDetail.la),
//          ),
          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).budget,
            formatNumberToDollars(mediaDetail.budget),
          ),
          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).revenue,
            formatNumberToDollars(mediaDetail.revenue),
          ),
          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).homepage,
            mediaDetail.homepage,
            true,
          ),
          _getMetaInfoSection(
            context,
            AppLocalizations.of(context).imdb,
            mediaDetail.imdbId,
            true,
          ),
        ],
      );

  Widget _getMetaInfoSection(BuildContext ctx, String title, String content,
      [bool isLink = false]) {
    if (content == null) {
      return Container();
    }
    var contentSection = Expanded(
      flex: 4,
      child: GestureDetector(
          onTap: () {},
          child: Text(
            content,
            style: isLink
                ? Theme.of(ctx)
                    .textTheme
                    .subhead
                    .copyWith(fontSize: 11.0, color: Colors.blue)
                : Theme.of(ctx).textTheme.subhead.copyWith(fontSize: 11.0),
          )),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              '${title}:',
              style: Theme.of(ctx)
                  .textTheme
                  .subhead
                  .copyWith(fontSize: 11.0, color: Colors.grey),
            ),
          ),
          contentSection,
        ],
      ),
    );
  }
}
