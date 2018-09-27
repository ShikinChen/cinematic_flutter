import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/model/media_detail.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:cinematic_flutter/util/api_client.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/util/text_util.dart';

class MetaSection extends StatelessWidget {
  final MediaDetail mediaDetail;

  MetaSection(this.mediaDetail);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildInfo(context),
    );
  }

  List<Widget> _buildInfo(BuildContext context) {
    final MediaType mediaType = ApiClient().mediaType;
    List<Widget> list = <Widget>[
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
    ];

    if (mediaType == MediaType.movie) {
      list.addAll([
        _getMetaInfoSection(
          context,
          AppLocalizations.of(context).runtime,
          formatRuntime(mediaDetail.runtime),
        ),
      ]);
    }
    list.addAll([
      _getMetaInfoSection(
        context,
        AppLocalizations.of(context).type,
        mediaDetail.genres.map((genre) => genre.name).toList().join(','),
      ),
    ]);

    if (mediaType == MediaType.tv) {
      list.addAll([
        _getMetaInfoSection(
          context,
          AppLocalizations.of(context).creators,
          mediaDetail.creator != null && mediaDetail.creator.isNotEmpty
              ? mediaDetail.creator[0].name
              : '',
        ),
        _getMetaInfoSection(
          context,
          AppLocalizations.of(context).networks,
          mediaDetail.creator != null && mediaDetail.creator.isNotEmpty
              ? mediaDetail.networks[0].name
              : '',
        ),
        _getMetaInfoSection(
          context,
          AppLocalizations.of(context).seasons,
          mediaDetail.numberOfSeasons != null &&
                  mediaDetail.numberOfEpisodes != null
              ? AppLocalizations.of(context).seasonsEpisodes(
                  mediaDetail.numberOfSeasons, mediaDetail.numberOfEpisodes)
              : '',
        ),
      ]);
    }

    list.addAll([
      _getMetaInfoSection(
        context,
        AppLocalizations.of(context).premiere,
        formatDate(mediaDetail.releaseDate ?? mediaDetail.firstAirDate),
      ),
    ]);
    if (mediaType == MediaType.tv) {
      list.addAll([
        _getMetaInfoSection(
          context,
          AppLocalizations.of(context).latest_next_episode,
          formatDate(mediaDetail.firstAirDate),
        ),
      ]);
    }
    if (mediaType == MediaType.movie) {
      list.addAll([
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
          AppLocalizations.of(context).imdb,
          mediaDetail.imdbId,
          true,
        ),
      ]);
    }

    list.addAll([
      _getMetaInfoSection(
        context,
        AppLocalizations.of(context).homepage,
        mediaDetail.homepage,
        true,
      ),
    ]);

    return list;
  }

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
