// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cast _$CastFromJson(Map<String, dynamic> json) {
  return Cast()
    ..cast_id = json['cast_id'] as int
    ..character = json['character'] as String
    ..creditId = json['credit_id'] as String
    ..gender = json['gender'] as int
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..order = json['order'] as int
    ..profilePath = json['profile_path'] as String;
}

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'cast_id': instance.cast_id,
      'character': instance.character,
      'credit_id': instance.creditId,
      'gender': instance.gender,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'profile_path': instance.profilePath
    };
