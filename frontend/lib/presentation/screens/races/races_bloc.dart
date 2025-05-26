import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_repository.dart';
import '../../../domain/models/driver/driver.dart';
import 'races_event.dart';
import 'races_state.dart';

class RacesBloc extends Bloc<RacesEvent, RacesState> {
  final DataRepository _repository;
  final Driver _seasonChampion;

  RacesBloc({
    required DataRepository repository,
    required Driver seasonChampion,
  }) : _repository = repository,
       _seasonChampion = seasonChampion,
       super(const RacesState.initial()) {
    on<RacesEvent>((event, emit) async {
      await event.map(
        loadRaces: (event) async {
          emit(const RacesState.loading());
          try {
            final races = await _repository.getSeasonRaces(event.season);
            emit(
              RacesState.loaded(races: races, seasonChampion: _seasonChampion),
            );
          } catch (e) {
            emit(RacesState.error(e.toString()));
          }
        },
      );
    });
  }
}
