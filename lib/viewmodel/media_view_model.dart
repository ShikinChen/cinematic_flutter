import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/util/date_time_util.dart';

class MediaViewModel {
  List<Media> list;

  static MediaViewModel fromStore(Store<AppState> store) => MediaViewModel()
    ..list = [
      Media()
        ..voteCount = 7531
        ..id = 299536
        ..video = false
        ..voteAverage = 8.3
        ..title = 'Avengers: Infinity War'
        ..popularity = 233.253
        ..posterPath =
            'https://image.tmdb.org/t/p/w300/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg'
        ..originalLanguage = 'en'
        ..originalTitle = 'Avengers: Infinity War'
        ..genreIds = [12, 878, 14, 28]
        ..backdropPath =
            'https://image.tmdb.org/t/p/w500/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg'
        ..adult = false
        ..overview =
            r'''As the Avengers and their allies have continued to protect 
            the world from threats too large for any one hero to handle, 
            a new danger has emerged from the cosmic shadows: Thanos. 
            A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, 
            artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. 
            Everything the Avengers have fought for has led up to this moment - 
            the fate of Earth and existence itself has never been more uncertain.'''
        ..releaseDate = toDateTime('2018-04-25')
    ];
}
