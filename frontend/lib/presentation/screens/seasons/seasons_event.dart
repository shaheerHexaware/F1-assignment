import 'package:freezed_annotation/freezed_annotation.dart';

part 'seasons_event.freezed.dart';

@freezed
class SeasonsEvent with _$SeasonsEvent {
  const factory SeasonsEvent.loadSeasons() = _LoadSeasons;
}
