import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/page/media_detail_page.dart';
import 'package:flutter/material.dart';

goToMediaDetail(BuildContext ctx, Media media) {
  _pushWidgetWithFade(ctx, MediaDetailPage(media));
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
