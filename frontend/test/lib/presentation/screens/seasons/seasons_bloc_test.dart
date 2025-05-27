import 'package:f1_app/helpers/env/enum_environment.dart';
import 'package:f1_app/helpers/env/env_variables.dart';
import 'package:f1_app/presentation/screens/seasons/event/seasons_event.dart';
import 'package:f1_app/presentation/screens/seasons/state/seasons_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:f1_app/data/data_repository.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'package:f1_app/presentation/screens/seasons/seasons_bloc.dart';
import '../../../dummies.dart';
import 'seasons_bloc_test.mocks.dart';

@GenerateMocks([DataRepository, EnvironmentVariables])
void main() {
  late SeasonsBloc bloc;
  late MockDataRepository mockRepository;
  late MockEnvironmentVariables mockEnvironmentVariables;
  setUp(() {
    mockRepository = MockDataRepository();
    mockEnvironmentVariables = MockEnvironmentVariables();
    bloc = SeasonsBloc(
      repository: mockRepository,
      environmentVariables: mockEnvironmentVariables,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is SeasonsState.loading', () {
    expect(bloc.state, const SeasonsState.loading());
  });

  group('LoadSeasons', () {
    final dummySeason = Dummies.createSeason();
    final List<Season> seasons = [dummySeason];

    blocTest<SeasonsBloc, SeasonsState>(
      'emits [loading, loaded] when seasons are loaded successfully',
      build: () {
        when(
          mockRepository.getSeasonsWithChampions(from: Dummies.dummySeason),
        ).thenAnswer((_) async => seasons);
        when(
          mockEnvironmentVariables.getValue(
            path: EnvironmentKeys.seasionStartYear,
          ),
        ).thenAnswer((_) async => Dummies.dummySeason.toString());
        return bloc;
      },
      act: (bloc) => bloc.add(const SeasonsEvent.loadSeasons()),
      expect: () => [
        const SeasonsState.loading(),
        SeasonsState.loaded(seasons),
      ],
      verify: (_) {
        verify(
          mockRepository.getSeasonsWithChampions(from: Dummies.dummySeason),
        ).called(1);
      },
    );

    blocTest<SeasonsBloc, SeasonsState>(
      'emits [loading, error] when loading seasons fails',
      build: () {
        when(
          mockEnvironmentVariables.getValue(
            path: EnvironmentKeys.seasionStartYear,
          ),
        ).thenAnswer((_) async => Dummies.dummySeason.toString());
        when(
          mockRepository.getSeasonsWithChampions(from: Dummies.dummySeason),
        ).thenThrow(Exception('Failed to load seasons'));
        return bloc;
      },
      act: (bloc) => bloc.add(const SeasonsEvent.loadSeasons()),
      expect: () => [
        const SeasonsState.loading(),
        const SeasonsState.error('Exception: Failed to load seasons'),
      ],
      verify: (_) {
        verify(
          mockRepository.getSeasonsWithChampions(from: Dummies.dummySeason),
        ).called(1);
      },
    );

    blocTest<SeasonsBloc, SeasonsState>(
      'emits [loading, loaded] with empty list when no seasons are found',
      build: () {
        when(
          mockEnvironmentVariables.getValue(
            path: EnvironmentKeys.seasionStartYear,
          ),
        ).thenAnswer((_) async => Dummies.dummySeason.toString());
        when(
          mockRepository.getSeasonsWithChampions(from: Dummies.dummySeason),
        ).thenAnswer((_) async => <Season>[]);
        return bloc;
      },
      act: (bloc) => bloc.add(const SeasonsEvent.loadSeasons()),
      expect: () => [
        const SeasonsState.loading(),
        const SeasonsState.loaded([]),
      ],
      verify: (_) {
        verify(
          mockRepository.getSeasonsWithChampions(from: Dummies.dummySeason),
        ).called(1);
      },
    );

    blocTest<SeasonsBloc, SeasonsState>(
      'emits [loading, loaded] with multiple seasons',
      build: () {
        when(
          mockEnvironmentVariables.getValue(
            path: EnvironmentKeys.seasionStartYear,
          ),
        ).thenAnswer((_) async => Dummies.dummySeason.toString());
        final multipleSeasons = [
          Dummies.createSeason(year: Dummies.dummySeason),
          Dummies.createSeason(year: Dummies.dummySeason + 1),
          Dummies.createSeason(year: Dummies.dummySeason + 2),
        ];
        when(
          mockRepository.getSeasonsWithChampions(from: Dummies.dummySeason),
        ).thenAnswer((_) async => multipleSeasons);
        return bloc;
      },
      act: (bloc) => bloc.add(const SeasonsEvent.loadSeasons()),
      expect: () => [
        const SeasonsState.loading(),
        SeasonsState.loaded([
          Dummies.createSeason(year: Dummies.dummySeason),
          Dummies.createSeason(year: Dummies.dummySeason + 1),
          Dummies.createSeason(year: Dummies.dummySeason + 2),
        ]),
      ],
      verify: (_) {
        verify(
          mockRepository.getSeasonsWithChampions(from: Dummies.dummySeason),
        ).called(1);
      },
    );
  });
}
