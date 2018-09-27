// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Network _$NetworkFromJson(Map<String, dynamic> json) {
  return Network()
    ..id = json['id'] as int
    ..logoPath = json['logo_path'] as String
    ..name = json['name'] as String
    ..originCountry = json['origin_country'] as String;
}

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry
    };
