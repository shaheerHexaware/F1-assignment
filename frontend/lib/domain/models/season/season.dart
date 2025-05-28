import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'season.freezed.dart';

@freezed
abstract class Season with _$Season {
  const factory Season({required int year, required Driver champion}) = _Season;
}
