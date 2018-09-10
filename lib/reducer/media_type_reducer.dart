import 'package:cinematic_flutter/model/media_type.dart';
import 'package:redux/redux.dart';
import 'package:cinematic_flutter/actions/actions.dart';

final mediaTypeReducer = combineReducers<MediaType>([
  TypedReducer<MediaType, MediaTypeSelectedAction>(_toggleThemeReducer),
]);

MediaType _toggleThemeReducer(MediaType mediaType, mediaTypeSelectedAction) =>
    mediaTypeSelectedAction.mediaType;
