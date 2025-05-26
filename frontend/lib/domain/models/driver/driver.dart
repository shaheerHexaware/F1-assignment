import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver.freezed.dart';

@freezed
abstract class Driver with _$Driver {
  const factory Driver({
    required String driverId,
    required String? code,
    required String givenName,
    required String familyName,
    required String dateOfBirth,
    required String nationality,
  }) = _Driver;
}
