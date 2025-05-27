// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RaceImpl _$$RaceImplFromJson(Map<String, dynamic> json) => _$RaceImpl(
  name: json['name'] as String,
  winner: Driver.fromJson(json['winner'] as Map<String, dynamic>),
  circuit: Circuit.fromJson(json['circuit'] as Map<String, dynamic>),
  constructor: Constructor.fromJson(
    json['constructor'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$RaceImplToJson(_$RaceImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'winner': instance.winner,
      'circuit': instance.circuit,
      'constructor': instance.constructor,
    };
