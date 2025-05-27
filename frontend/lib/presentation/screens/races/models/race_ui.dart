import 'package:freezed_annotation/freezed_annotation.dart';

part 'race_ui.freezed.dart';

@freezed
abstract class RaceUi with _$RaceUi {
  const factory RaceUi({
    required int year,
    required int round,
    required String name,
    required String date,
    required String driverName,
    required bool isWinnerChampion,
    required String circuitName,
    required String constructorName,
  }) = _RaceUi;
}
