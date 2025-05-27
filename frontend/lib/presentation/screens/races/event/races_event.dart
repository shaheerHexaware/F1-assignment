import 'package:freezed_annotation/freezed_annotation.dart';

part 'races_event.freezed.dart';

@freezed
class RacesEvent with _$RacesEvent {
  const factory RacesEvent.loadRaces(int season) = _LoadRaces;
}
