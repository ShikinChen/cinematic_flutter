import 'package:cinematic_flutter/bloc/app_state_bloc.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/cast.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/media_bean.dart';
import 'package:cinematic_flutter/model/media_detail.dart';
import 'package:cinematic_flutter/bloc/media_bloc.dart';
import 'package:cinematic_flutter/provider/app_state_provider.dart';
import 'package:cinematic_flutter/provider/media_provider.dart';
import 'package:cinematic_flutter/util/api_client_util.dart';
import 'package:cinematic_flutter/widget/bottom_gradient.dart';
import 'package:cinematic_flutter/widget/cast_section.dart';
import 'package:cinematic_flutter/widget/meta_section.dart';
import 'package:cinematic_flutter/widget/text_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/util/text_util.dart';
import 'package:cinematic_flutter/widget/similar_section.dart';
import 'package:logging/logging.dart';
import 'package:cinematic_flutter/model/media_type.dart';

class MediaDetailPage extends StatelessWidget {
  Media _media;
  final Logger logger = Logger('MediaDetailPage');
  final MediaBloc mediaBloc = MediaBloc();

  MediaDetailPage(Media media) {
    this._media = media;
    if (media.mediaType == null) {
      this._media.mediaType = getMediaTypeName(ApiClientUtil().mediaType);
    }
    mediaBloc.getCastListAction(media);
    mediaBloc.getMediaDetailAction(media);
    mediaBloc.getSimilarListAction(media);
    mediaBloc.getCollectAction(media.id);
  }

  final tagBgColor = Color(0xffF47663);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(context),
            _buildContent(context),
          ],
        ),
      );

  Widget _buildAppBar(BuildContext ctx) {
    logger.fine('media.id--${_media.id}');
    return StreamBuilder(
      stream: mediaBloc.collect,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
          SliverAppBar(
              expandedHeight: 240.0,
              pinned: true,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    mediaBloc.saveCollectAction(_media);
                  },
                  icon: Icon(
                    snapshot.data ? Icons.favorite : Icons.favorite_border,
                    color: snapshot.data ? Colors.redAccent : Colors.white,
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Hero(
                        tag: _media.tag,
                        child: StreamBuilder(
                          stream: mediaBloc.mediaDetail,
                          builder: (BuildContext ctx,
                                  AsyncSnapshot<MediaDetail> snapshot) =>
                              _media.backdropPath == null ||
                                      snapshot.data == null ||
                                      _media.backdropPath == null
                                  ? Image.asset(
                                      'assets/images/placeholder.jpg',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                  : FadeInImage.assetNetwork(
                                      fit: BoxFit.cover,
                                      placeholder:
                                          'assets/images/placeholder.jpg',
                                      width: double.infinity,
                                      image: _media.backdropPath ??
                                          snapshot.data.backdropPath,
                                    ),
                        )),
                    BottomGradient(),
                    _buildMeta(ctx),
                  ],
                ),
              )),
    );
  }

  Widget _buildMeta(BuildContext ctx) => AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(
          milliseconds: 500,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  TextBubble(
                    (_media.releaseDate != null
                            ? _media.releaseDate
                            : _media.firstAirDate)
                        .year
                        .toString(),
                    backgroundColor: tagBgColor,
                  ),
                  Container(
                    width: 8.0,
                  ),
                  TextBubble(
                    _media.voteAverage.toString(),
                    backgroundColor: tagBgColor,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _media.title ?? _media.name,
                  style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 20.0),
                ),
              ),
              Row(
                children: getGenresForIds(_media.genreIds, ctx)
                    .map((text) => Row(
                          children: <Widget>[
                            TextBubble(text),
                            Container(
                              width: 8.0,
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      );

  Widget _buildContent(BuildContext ctx) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            decoration:
                BoxDecoration(color: Theme.of(ctx).scaffoldBackgroundColor),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(ctx).synopsis,
                  ),
                  Container(
                    height: 8.0,
                  ),
                  Text(
                    _media.overview ?? '',
                    style: Theme.of(ctx)
                        .textTheme
                        .subhead
                        .copyWith(fontSize: 12.0),
                  ),
                  Container(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Theme.of(ctx).scaffoldBackgroundColor),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: StreamBuilder<List<Cast>>(
                  stream: mediaBloc.castList,
                  builder:
                      (BuildContext ctx, AsyncSnapshot<List<Cast>> snapshot) =>
                          snapshot.data == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CastSection(snapshot.data)),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Theme.of(ctx).scaffoldBackgroundColor),
            padding: EdgeInsets.all(16.0),
            child: StreamBuilder(
                stream: mediaBloc.mediaDetail,
                builder:
                    (BuildContext ctx, AsyncSnapshot<MediaDetail> snapshot) =>
                        snapshot.data == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : MetaSection(snapshot.data)),
          ),
          Container(
            decoration:
                BoxDecoration(color: Theme.of(ctx).scaffoldBackgroundColor),
            child: StreamBuilder(
              stream: mediaBloc.similarList,
              builder:
                  (BuildContext ctx, AsyncSnapshot<List<Media>> snapshot) =>
                      snapshot.data == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SimilarSection(snapshot.data),
            ),
          ),
        ],
      ),
    );
  }
}
