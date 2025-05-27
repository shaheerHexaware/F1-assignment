// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circuit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CircuitImpl _$$CircuitImplFromJson(Map<String, dynamic> json) =>
    _$CircuitImpl(
      circuitId: json['circuitId'] as String,
      circuitName: json['circuitName'] as String,
      locality: json['locality'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$$CircuitImplToJson(_$CircuitImpl instance) =>
    <String, dynamic>{
      'circuitId': instance.circuitId,
      'circuitName': instance.circuitName,
      'locality': instance.locality,
      'country': instance.country,
    };
