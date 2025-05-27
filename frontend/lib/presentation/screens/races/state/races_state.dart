import 'package:f1_app/presentation/screens/races/models/race_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'races_state.freezed.dart';

@freezed
class RacesState with _$RacesState {
  const factory RacesState.loading() = _Loading;
  const factory RacesState.loaded({required List<RaceUi> races}) = _Loaded;
  const factory RacesState.error(String message) = _Error;
}
