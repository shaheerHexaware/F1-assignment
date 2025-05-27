import 'package:f1_app/presentation/screens/races/mapper/race_ui_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_repository.dart';
import '../../../domain/models/driver/driver.dart';
import 'event/races_event.dart';
import 'state/races_state.dart';

class RacesBloc extends Bloc<RacesEvent, RacesState> {
  final DataRepository _repository;
  final Driver _seasonChampion;
  final RaceUiMapper _raceUiMapper;

  RacesBloc({
    required DataRepository repository,
    required Driver seasonChampion,
    RaceUiMapper? raceUiMapper,
  }) : _repository = repository,
       _seasonChampion = seasonChampion,
       _raceUiMapper = raceUiMapper ?? RaceUiMapper(),
       super(const RacesState.loading()) {
    on<RacesEvent>((event, emit) async {
      await event.map(
        loadRaces: (event) async {
          emit(const RacesState.loading());
          try {
            final races = await _repository.getSeasonRaces(event.season);
            final racesUi = races
                .map(
                  (race) => _raceUiMapper.map(
                    race,
                    metadata: race.winner.driverId == _seasonChampion.driverId,
                  ),
                )
                .toList();
            emit(RacesState.loaded(races: racesUi));
          } catch (e) {
            emit(RacesState.error(e.toString()));
          }
        },
      );
    });
  }
}
