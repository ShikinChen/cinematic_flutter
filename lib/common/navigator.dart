import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/page/collection_media_list_page.dart';
import 'package:cinematic_flutter/page/media_detail_page.dart';
import 'package:cinematic_flutter/page/saerch_page.dart';
import 'package:cinematic_flutter/provider/media_provider.dart';
import 'package:flutter/material.dart';

goToMediaDetail(BuildContext ctx, Media media) {
  _pushWidgetWithFade(ctx, MediaDetailPage(media));
}

goToCollectionMediaListPage(BuildContext ctx) {
  _pushWidgetWithFade(ctx, CollectionMediaListPage());
}

goToSearchPage(BuildContext ctx) {
  final mediaBloc = MediaProvider.of(ctx);
  mediaBloc.getMediaSearch();
  _pushWidgetWithFade(ctx, SearchPage());
}

_pushWidgetWithFade(BuildContext ctx, Widget widget) {
  Navigator.of(ctx).push(
    PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (BuildContext ctx, Animation animation,
              Animation secondaryAnimation) =>
          widget,
    ),
  );
}
