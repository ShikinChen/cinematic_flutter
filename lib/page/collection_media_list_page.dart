import 'package:cinematic_flutter/provider/media_provider.dart';
import 'package:flutter/material.dart';
import 'package:cinematic_flutter/widget/media_list.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:logging/logging.dart';

class CollectionMediaListPage extends StatelessWidget {
  final Logger logger = Logger('CollectionMediaListPage');
  final mediaList = MediaList(
    isCollection: true,
  );

  @override
  Widget build(BuildContext ctx) {
    final mediaBloc = MediaProvider.of(ctx);
    mediaBloc.getCollectionMediaListAction();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(AppLocalizations.of(ctx).favorites),
      ),
      body: mediaList,
    );
  }
}
