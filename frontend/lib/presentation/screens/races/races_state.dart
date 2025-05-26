import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/models/race/race.dart';
import '../../../domain/models/driver/driver.dart';

part 'races_state.freezed.dart';

@freezed
class RacesState with _$RacesState {
  const factory RacesState.initial() = _Initial;
  const factory RacesState.loading() = _Loading;
  const factory RacesState.loaded({
    required List<Race> races,
    required Driver seasonChampion,
  }) = _Loaded;
  const factory RacesState.error(String message) = _Error;
}
