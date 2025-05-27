// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverImpl _$$DriverImplFromJson(Map<String, dynamic> json) => _$DriverImpl(
  driverId: json['driverId'] as String,
  code: json['code'] as String?,
  givenName: json['givenName'] as String,
  familyName: json['familyName'] as String,
  dateOfBirth: json['dateOfBirth'] as String,
  nationality: json['nationality'] as String,
);

Map<String, dynamic> _$$DriverImplToJson(_$DriverImpl instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'code': instance.code,
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'dateOfBirth': instance.dateOfBirth,
      'nationality': instance.nationality,
    };
