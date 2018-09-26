// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditsRes _$CreditsResFromJson(Map<String, dynamic> json) {
  return CreditsRes()
    ..id = json['id'] as int
    ..cast = (json['cast'] as List)
        ?.map(
            (e) => e == null ? null : Cast.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CreditsResToJson(CreditsRes instance) =>
    <String, dynamic>{'id': instance.id, 'cast': instance.cast};
