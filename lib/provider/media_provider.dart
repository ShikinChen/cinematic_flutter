import 'package:cinematic_flutter/bloc/media_bloc.dart';
import 'package:cinematic_flutter/bloc/app_state_bloc.dart';
import 'package:flutter/material.dart';

class MediaProvider extends InheritedWidget {
  final MediaBloc mediaBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  MediaProvider({
    Key key,
    MediaBloc mediaBloc,
    Widget child,
  })  : mediaBloc = mediaBloc ?? MediaBloc(),
        super(
          key: key,
          child: child,
        );

  static MediaBloc of(BuildContext ctx) =>
      (ctx.inheritFromWidgetOfExactType(MediaProvider) as MediaProvider).mediaBloc;
}
