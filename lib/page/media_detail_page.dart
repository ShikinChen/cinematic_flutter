import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:cinematic_flutter/viewmodel/media_view_model.dart';
import 'package:cinematic_flutter/widget/app_tab_bar.dart';
import 'package:cinematic_flutter/widget/bottom_gradient.dart';
import 'package:cinematic_flutter/widget/cast_section.dart';
import 'package:cinematic_flutter/widget/text_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/model/app_tab.dart';
import 'package:cinematic_flutter/widget/media_list.dart';
import 'package:cinematic_flutter/widget/toggle_theme_button.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/widget/language_dialog.dart';
import 'package:cinematic_flutter/viewmodel/home_view_model.dart';
import 'package:logging/logging.dart';
import 'package:cinematic_flutter/util/text_util.dart';
import 'package:cinematic_flutter/localizations.dart';

class MediaDetailPage extends StatelessWidget {
  MediaViewModel _vm;
  final Media media;

  final tagBgColor = Color(0xffF47663);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, MediaViewModel>(
        distinct: true,
        onInit: (store) => _vm = MediaViewModel.fromStore(store),
        converter: (store) => _vm = _vm ?? MediaViewModel.fromStore(store),
        builder: (ctx, vm) => Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  _buildAppBar(context),
                  _buildContent(context),
                ],
              ),
            ),
      );

  MediaDetailPage(this.media);

  Widget _buildAppBar(BuildContext ctx) => SliverAppBar(
        expandedHeight: 240.0,
        pinned: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border,
            ),
          ),
        ],
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: 'media_tag_${media.id}',
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/images/placeholder.jpg',
                width: double.infinity,
                image: media.backdropPath,
              ),
            ),
            BottomGradient(),
            _buildMeta(ctx),
          ],
        ),
      );

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
                    media.releaseDate.year.toString(),
                    backgroundColor: tagBgColor,
                  ),
                  Container(
                    width: 8.0,
                  ),
                  TextBubble(
                    media.voteAverage.toString(),
                    backgroundColor: tagBgColor,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  media.title,
                  style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 20.0),
                ),
              ),
              Row(
                children: getGenresForIds(media.genreIds, ctx)
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

  Widget _buildContent(BuildContext ctx) => SliverList(
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
                      media.overview,
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
                child: CastSection([]),
              ),
            ),
          ],
        ),
      );
}
