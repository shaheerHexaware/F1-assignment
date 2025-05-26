import 'package:freezed_annotation/freezed_annotation.dart';

import '../driver/driver.dart';

part 'season.freezed.dart';

@freezed
abstract class Season with _$Season {
  const factory Season({required int year, required Driver champion}) = _Season;
}
