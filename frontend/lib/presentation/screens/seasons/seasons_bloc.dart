import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_repository.dart';
import 'seasons_event.dart';
import 'seasons_state.dart';

class SeasonsBloc extends Bloc<SeasonsEvent, SeasonsState> {
  final DataRepository _repository;

  SeasonsBloc({required DataRepository repository})
    : _repository = repository,
      super(const SeasonsState.initial()) {
    on<SeasonsEvent>((event, emit) async {
      await event.map(
        loadSeasons: (_) async {
          emit(const SeasonsState.loading());
          try {
            final seasons = await _repository.getSeasonsWithChampions(
              from: 2005,
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
