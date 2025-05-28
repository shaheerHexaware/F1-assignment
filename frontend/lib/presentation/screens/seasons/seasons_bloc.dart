import 'package:f1_app/helpers/env/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_repository.dart';
import 'event/seasons_event.dart';
import 'state/seasons_state.dart';

class SeasonsBloc extends Bloc<SeasonsEvent, SeasonsState> {
  final DataRepository _repository;
  final String _startYear;

  SeasonsBloc({required DataRepository repository, String? startYear})
    : _repository = repository,
      _startYear = startYear ?? seasonStartYear,
      super(const SeasonsState.loading()) {
    on<SeasonsEvent>((event, emit) async {
      await event.map(
        loadSeasons: (_) async {
          emit(const SeasonsState.loading());
          try {
            final seasons = await _repository.getSeasonsWithChampions(
              from: int.parse(_startYear),
            );
            emit(SeasonsState.loaded(seasons));
          } catch (e) {
            emit(SeasonsState.error(e.toString()));
          }
        },
      );
    });
  }
}
