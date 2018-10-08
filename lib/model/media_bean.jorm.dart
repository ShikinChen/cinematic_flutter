// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _MediaBean implements Bean<Media> {
  final voteCount = IntField('vote_count');
  final id = IntField('id');
  final video = BoolField('video');
  final voteAverage = DoubleField('vote_average');
  final title = StrField('title');
  final name = StrField('name');
  final popularity = DoubleField('popularity');
  final posterPath = StrField('poster_path');
  final originalLanguage = StrField('original_language');
  final originalTitle = StrField('original_title');
  final backdropPath = StrField('backdrop_path');
  final adult = BoolField('adult');
  final overview = StrField('overview');
  final releaseDate = DateTimeField('release_date');
  final firstAirDate = DateTimeField('first_air_date');
  final genreIdsJson = StrField('genre_ids_json');
  final mediaType = StrField('media_type');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        voteCount.name: voteCount,
        id.name: id,
        video.name: video,
        voteAverage.name: voteAverage,
        title.name: title,
        name.name: name,
        popularity.name: popularity,
        posterPath.name: posterPath,
        originalLanguage.name: originalLanguage,
        originalTitle.name: originalTitle,
        backdropPath.name: backdropPath,
        adult.name: adult,
        overview.name: overview,
        releaseDate.name: releaseDate,
        firstAirDate.name: firstAirDate,
        genreIdsJson.name: genreIdsJson,
        mediaType.name: mediaType,
      };
  Media fromMap(Map map) {
    Media model = Media();
    model.voteCount = adapter.parseValue(map['vote_count']);
    model.id = adapter.parseValue(map['id']);
    model.video = adapter.parseValue(map['video']);
    model.voteAverage = adapter.parseValue(map['vote_average']);
    model.title = adapter.parseValue(map['title']);
    model.name = adapter.parseValue(map['name']);
    model.popularity = adapter.parseValue(map['popularity']);
    model.posterPath = adapter.parseValue(map['poster_path']);
    model.originalLanguage = adapter.parseValue(map['original_language']);
    model.originalTitle = adapter.parseValue(map['original_title']);
    model.backdropPath = adapter.parseValue(map['backdrop_path']);
    model.adult = adapter.parseValue(map['adult']);
    model.overview = adapter.parseValue(map['overview']);
    model.releaseDate = adapter.parseValue(map['release_date']);
    model.firstAirDate = adapter.parseValue(map['first_air_date']);
    model.genreIdsJson = adapter.parseValue(map['genre_ids_json']);
    model.mediaType = adapter.parseValue(map['media_type']);

    return model;
  }

  List<SetColumn> toSetColumns(Media model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(voteCount.set(model.voteCount));
      ret.add(id.set(model.id));
      ret.add(video.set(model.video));
      ret.add(voteAverage.set(model.voteAverage));
      ret.add(title.set(model.title));
      ret.add(name.set(model.name));
      ret.add(popularity.set(model.popularity));
      ret.add(posterPath.set(model.posterPath));
      ret.add(originalLanguage.set(model.originalLanguage));
      ret.add(originalTitle.set(model.originalTitle));
      ret.add(backdropPath.set(model.backdropPath));
      ret.add(adult.set(model.adult));
      ret.add(overview.set(model.overview));
      ret.add(releaseDate.set(model.releaseDate));
      ret.add(firstAirDate.set(model.firstAirDate));
      ret.add(genreIdsJson.set(model.genreIdsJson));
      ret.add(mediaType.set(model.mediaType));
    } else {
      if (only.contains(voteCount.name))
        ret.add(voteCount.set(model.voteCount));
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(video.name)) ret.add(video.set(model.video));
      if (only.contains(voteAverage.name))
        ret.add(voteAverage.set(model.voteAverage));
      if (only.contains(title.name)) ret.add(title.set(model.title));
      if (only.contains(name.name)) ret.add(name.set(model.name));
      if (only.contains(popularity.name))
        ret.add(popularity.set(model.popularity));
      if (only.contains(posterPath.name))
        ret.add(posterPath.set(model.posterPath));
      if (only.contains(originalLanguage.name))
        ret.add(originalLanguage.set(model.originalLanguage));
      if (only.contains(originalTitle.name))
        ret.add(originalTitle.set(model.originalTitle));
      if (only.contains(backdropPath.name))
        ret.add(backdropPath.set(model.backdropPath));
      if (only.contains(adult.name)) ret.add(adult.set(model.adult));
      if (only.contains(overview.name)) ret.add(overview.set(model.overview));
      if (only.contains(releaseDate.name))
        ret.add(releaseDate.set(model.releaseDate));
      if (only.contains(firstAirDate.name))
        ret.add(firstAirDate.set(model.firstAirDate));
      if (only.contains(genreIdsJson.name))
        ret.add(genreIdsJson.set(model.genreIdsJson));
      if (only.contains(mediaType.name))
        ret.add(mediaType.set(model.mediaType));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
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

  Future<dynamic> insert(Media model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Media> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Media model) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Media> models) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<int> update(Media model, {Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Media> models) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Media> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Media> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
