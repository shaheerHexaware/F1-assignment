// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RaceImpl _$$RaceImplFromJson(Map<String, dynamic> json) => _$RaceImpl(
  year: (json['year'] as num).toInt(),
  round: (json['round'] as num).toInt(),
  name: json['name'] as String,
  date: json['date'] as String,
  winner: Driver.fromJson(json['winner'] as Map<String, dynamic>),
  circuit: Circuit.fromJson(json['circuit'] as Map<String, dynamic>),
  constructor: Constructor.fromJson(
    json['constructor'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$RaceImplToJson(_$RaceImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'round': instance.round,
      'name': instance.name,
      'date': instance.date,
      'winner': instance.winner,
      'circuit': instance.circuit,
      'constructor': instance.constructor,
    };
