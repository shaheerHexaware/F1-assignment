import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:f1_app/data/data_repository.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'package:f1_app/presentation/screens/seasons/seasons_bloc.dart';
import 'package:f1_app/presentation/screens/seasons/seasons_event.dart';
import 'package:f1_app/presentation/screens/seasons/seasons_state.dart';
import '../../../dummies.dart';
import 'seasons_bloc_test.mocks.dart';

@GenerateMocks([DataRepository])
void main() {
  late SeasonsBloc bloc;
  late MockDataRepository mockRepository;

  setUp(() {
    mockRepository = MockDataRepository();
    bloc = SeasonsBloc(repository: mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is SeasonsState.initial', () {
    expect(bloc.state, const SeasonsState.initial());
  });

  group('LoadSeasons', () {
    final dummySeason = Dummies.createSeason();
    final List<Season> seasons = [dummySeason];

    blocTest<SeasonsBloc, SeasonsState>(
      'emits [loading, loaded] when seasons are loaded successfully',
      build: () {
        when(
          mockRepository.getSeasonsWithChampions(from: 2005),
        ).thenAnswer((_) async => seasons);
        return bloc;
      },
      act: (bloc) => bloc.add(const SeasonsEvent.loadSeasons()),
      expect: () => [
        const SeasonsState.loading(),
        SeasonsState.loaded(seasons),
      ],
      verify: (_) {
        verify(mockRepository.getSeasonsWithChampions(from: 2005)).called(1);
      },
    );

    blocTest<SeasonsBloc, SeasonsState>(
      'emits [loading, error] when loading seasons fails',
      build: () {
        when(
          mockRepository.getSeasonsWithChampions(from: 2005),
        ).thenThrow(Exception('Failed to load seasons'));
        return bloc;
      },
      act: (bloc) => bloc.add(const SeasonsEvent.loadSeasons()),
      expect: () => [
        const SeasonsState.loading(),
        const SeasonsState.error('Exception: Failed to load seasons'),
      ],
      verify: (_) {
        verify(mockRepository.getSeasonsWithChampions(from: 2005)).called(1);
      },
    );

    blocTest<SeasonsBloc, SeasonsState>(
      'emits [loading, loaded] with empty list when no seasons are found',
      build: () {
        when(
          mockRepository.getSeasonsWithChampions(from: 2005),
        ).thenAnswer((_) async => <Season>[]);
        return bloc;
      },
      act: (bloc) => bloc.add(const SeasonsEvent.loadSeasons()),
      expect: () => [
        const SeasonsState.loading(),
        const SeasonsState.loaded([]),
      ],
      verify: (_) {
        verify(mockRepository.getSeasonsWithChampions(from: 2005)).called(1);
      },
    );

    blocTest<SeasonsBloc, SeasonsState>(
      'emits [loading, loaded] with multiple seasons',
      build: () {
        final multipleSeasons = [
          Dummies.createSeason(year: 2005),
          Dummies.createSeason(year: 2006),
          Dummies.createSeason(year: 2007),
        ];
        when(
          mockRepository.getSeasonsWithChampions(from: 2005),
        ).thenAnswer((_) async => multipleSeasons);
        return bloc;
      },
      act: (bloc) => bloc.add(const SeasonsEvent.loadSeasons()),
      expect: () => [
        const SeasonsState.loading(),
        SeasonsState.loaded([
          Dummies.createSeason(year: 2005),
          Dummies.createSeason(year: 2006),
          Dummies.createSeason(year: 2007),
        ]),
      ],
      verify: (_) {
        verify(mockRepository.getSeasonsWithChampions(from: 2005)).called(1);
      },
    );
  });
}
