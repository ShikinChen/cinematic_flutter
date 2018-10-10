import 'package:cinematic_flutter/bloc/media_bloc.dart';
import 'package:cinematic_flutter/model/media_list_type.dart';
import 'package:cinematic_flutter/provider/media_provider.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/widget/media_list.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:logging/logging.dart';

class SearchPage extends StatelessWidget {
  final int dis = 2;
  final Logger logger = Logger('SearchPage');
  final mediaList = MediaList(
    mediaListType: MediaListType.search,
  );

  @override
  Widget build(BuildContext ctx) {
    final mediaBloc = MediaProvider.of(ctx);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(ctx).search,
            border: InputBorder.none,
          ),
          onChanged: (value) => mediaBloc.mediaSearchAction(keyword: value),
        ),
      ),
      body: mediaList,
    );
  }
}
