import 'dart:async';
import 'dart:convert';

import 'package:cinematic_flutter/model/media.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:logging/logging.dart';

part 'media_bean.jorm.dart';

@GenBean()
class MediaBean extends Bean<Media> with _MediaBean {
  final Logger logger = Logger('MediaBean');

  MediaBean(Adapter adapter) : super(adapter);

  Future<dynamic> insertMedia(Media model) async {
    await initTable();
    String jsonText = JsonEncoder().convert(model.genreIds);
    return super.insert(model..genreIdsJson = jsonText);
  }

  Future<int> updateMedia(Media model) async {
    await initTable();
    String jsonText = JsonEncoder().convert(model.genreIds);
    return super.update(model..genreIdsJson = jsonText);
  }

  Future<int> removeMedia(Media model) async {
    await initTable();
    return super.remove(model.id);
  }

  Future<List<Media>> queryAll() async {
    await initTable();
    return super.getAll();
  }

  initTable() async {
    final st = Sql.create(tableName, ifNotExists: true);
    st.addInt(voteCount.name, isNullable: true);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addBool(video.name, isNullable: true);
    st.addDouble(voteAverage.name, isNullable: true);
    st.addStr(title.name, isNullable: true);
    st.addStr(name.name, isNullable: true);
    st.addDouble(popularity.name, isNullable: true);
    st.addStr(posterPath.name, isNullable: true);
    st.addStr(originalLanguage.name, isNullable: true);
    st.addStr(originalTitle.name, isNullable: true);
    st.addStr(backdropPath.name, isNullable: true);
    st.addBool(adult.name, isNullable: true);
    st.addStr(overview.name, isNullable: true);
    st.addDateTime(releaseDate.name, isNullable: true);
    st.addDateTime(firstAirDate.name, isNullable: true);
    st.addStr(genreIdsJson.name, isNullable: true);
    st.addStr(mediaType.name, isNullable: true);
    return adapter.createTable(st);
  }

  final String tableName = 'media';

  final bool ifNotExists = true;
}
