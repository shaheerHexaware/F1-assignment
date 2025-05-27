import 'package:f1_app/presentation/screens/races/models/race_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:f1_app/data/data_repository.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/presentation/screens/races/races_bloc.dart';
import 'package:f1_app/presentation/screens/races/event/races_event.dart';
import 'package:f1_app/presentation/screens/races/state/races_state.dart';
import '../../../dummies.dart';
import 'races_bloc_test.mocks.dart';

@GenerateMocks([DataRepository])
void main() {
  late RacesBloc bloc;
  late MockDataRepository mockRepository;
  late Driver dummyChampion;
  const int testSeason = 2023;

  setUp(() {
    mockRepository = MockDataRepository();
    dummyChampion = Dummies.createDriver();
    bloc = RacesBloc(repository: mockRepository, seasonChampion: dummyChampion);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is RacesState.loading', () {
    expect(bloc.state, const RacesState.loading());
  });

  group('LoadRaces', () {
    final dummyRace = Dummies.createRace();
    final List<Race> races = [dummyRace];
    final dummyRaceUi = Dummies.createRaceUi(isWinnerChampion: true);
    final List<RaceUi> racesUi = [dummyRaceUi];
    blocTest<RacesBloc, RacesState>(
      'emits [loading, loaded] when races are loaded successfully',
      build: () {
        when(
          mockRepository.getSeasonRaces(testSeason),
        ).thenAnswer((_) async => races);
        return bloc;
      },
      act: (bloc) => bloc.add(const RacesEvent.loadRaces(testSeason)),
      expect: () => [
        const RacesState.loading(),
        RacesState.loaded(races: racesUi),
      ],
      verify: (_) {
        verify(mockRepository.getSeasonRaces(testSeason)).called(1);
      },
    );

    blocTest<RacesBloc, RacesState>(
      'emits [loading, error] when loading races fails',
      build: () {
        when(
          mockRepository.getSeasonRaces(testSeason),
        ).thenThrow(Exception('Failed to load races'));
        return bloc;
      },
      act: (bloc) => bloc.add(const RacesEvent.loadRaces(testSeason)),
      expect: () => [
        const RacesState.loading(),
        const RacesState.error('Exception: Failed to load races'),
      ],
      verify: (_) {
        verify(mockRepository.getSeasonRaces(testSeason)).called(1);
      },
    );

    blocTest<RacesBloc, RacesState>(
      'emits [loading, loaded] with empty list when no races are found',
      build: () {
        when(
          mockRepository.getSeasonRaces(testSeason),
        ).thenAnswer((_) async => <Race>[]);
        return bloc;
      },
      act: (bloc) => bloc.add(const RacesEvent.loadRaces(testSeason)),
      expect: () => [
        const RacesState.loading(),
        RacesState.loaded(races: const []),
      ],
      verify: (_) {
        verify(mockRepository.getSeasonRaces(testSeason)).called(1);
      },
    );
  });
}
