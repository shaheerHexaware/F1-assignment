import 'package:f1_app/helpers/env/enum_environment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_repository.dart';
import '../../../helpers/env/env_variables.dart';
import 'event/seasons_event.dart';
import 'state/seasons_state.dart';

class SeasonsBloc extends Bloc<SeasonsEvent, SeasonsState> {
  final DataRepository _repository;
  final EnvironmentVariables _environmentVariables;

  SeasonsBloc({
    required DataRepository repository,
    EnvironmentVariables? environmentVariables,
  }) : _repository = repository,
       _environmentVariables =
           environmentVariables ?? EnvironmentVariables.instance,
       super(const SeasonsState.loading()) {
    on<SeasonsEvent>((event, emit) async {
      await event.map(
        loadSeasons: (_) async {
          emit(const SeasonsState.loading());
          final from = await _environmentVariables.getValue(
            path: EnvironmentKeys.seasionStartYear,
          );
          try {
            final seasons = await _repository.getSeasonsWithChampions(
              from: int.parse(from),
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
