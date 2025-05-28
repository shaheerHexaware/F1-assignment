import 'package:f1_app/data/data_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:f1_app/data/data_repository.dart';
import 'package:f1_app/data/remote/remote_data_source.dart';
import 'package:f1_app/data/cache/cache_data_source.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'package:f1_app/domain/models/race/race.dart';
import '../dummies.dart';
import 'data_repository_test.mocks.dart';

@GenerateMocks([RemoteDataSource, CacheDataSource])
void main() {
  late DataRepository repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockCacheDataSource mockCacheDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockCacheDataSource = MockCacheDataSource();
    repository = DataRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      cacheDataSource: mockCacheDataSource,
    );
  });

  group('getSeasonsWithChampions', () {
    final dummySeason = Dummies.createSeason();
    final List<Season> seasons = [dummySeason];

    test('returns seasons from remote and caches them', () async {
      when(
        mockRemoteDataSource.getSeasonsWithChampions(from: null, to: null),
      ).thenAnswer((_) async => seasons);
      when(
        mockCacheDataSource.cacheSeasonsWithChampions(
          seasons,
          from: null,
          to: null,
        ),
      ).thenAnswer((_) async => {});
      when(
        mockCacheDataSource.getSeasonsWithChampions(from: null, to: null),
      ).thenAnswer((_) async => seasons);

      final result = await repository.getSeasonsWithChampions();

      expect(result, equals(seasons));
      verifyInOrder([
        mockRemoteDataSource.getSeasonsWithChampions(from: null, to: null),
        mockCacheDataSource.cacheSeasonsWithChampions(
          seasons,
          from: null,
          to: null,
        ),
        mockCacheDataSource.getSeasonsWithChampions(from: null, to: null),
      ]);
    });

    test('returns filtered seasons from remote and caches them', () async {
      const from = 2020;
      const to = 2023;

      when(
        mockRemoteDataSource.getSeasonsWithChampions(from: from, to: to),
      ).thenAnswer((_) async => seasons);
      when(
        mockCacheDataSource.cacheSeasonsWithChampions(
          seasons,
          from: from,
          to: to,
        ),
      ).thenAnswer((_) async => {});
      when(
        mockCacheDataSource.getSeasonsWithChampions(from: from, to: to),
      ).thenAnswer((_) async => seasons);

      final result = await repository.getSeasonsWithChampions(
        from: from,
        to: to,
      );

      expect(result, equals(seasons));
      verifyInOrder([
        mockRemoteDataSource.getSeasonsWithChampions(from: from, to: to),
        mockCacheDataSource.cacheSeasonsWithChampions(
          seasons,
          from: from,
          to: to,
        ),
        mockCacheDataSource.getSeasonsWithChampions(from: from, to: to),
      ]);
    });

    test(
      'returns cached seasons when remote fails and cache is not empty',
      () async {
        when(
          mockRemoteDataSource.getSeasonsWithChampions(from: null, to: null),
        ).thenThrow(Exception('API error'));
        when(
          mockCacheDataSource.getSeasonsWithChampions(from: null, to: null),
        ).thenAnswer((_) async => seasons);

        final result = await repository.getSeasonsWithChampions();

        expect(result, equals(seasons));
        verify(
          mockRemoteDataSource.getSeasonsWithChampions(from: null, to: null),
        ).called(1);
        verify(
          mockCacheDataSource.getSeasonsWithChampions(from: null, to: null),
        ).called(1);
        verifyNever(
          mockCacheDataSource.cacheSeasonsWithChampions(
            any,
            from: null,
            to: null,
          ),
        );
      },
    );

    test('throws error when remote fails and cache is empty', () async {
      when(
        mockRemoteDataSource.getSeasonsWithChampions(from: null, to: null),
      ).thenThrow(Exception('API error'));
      when(
        mockCacheDataSource.getSeasonsWithChampions(from: null, to: null),
      ).thenAnswer((_) async => <Season>[]);

      expect(
        () => repository.getSeasonsWithChampions(),
        throwsA(isA<Exception>()),
      );

      verify(
        mockRemoteDataSource.getSeasonsWithChampions(from: null, to: null),
      ).called(1);
      verify(
        mockCacheDataSource.getSeasonsWithChampions(from: null, to: null),
      ).called(1);
      verifyNever(
        mockCacheDataSource.cacheSeasonsWithChampions(
          any,
          from: null,
          to: null,
        ),
      );
    });
  });

  group('getSeasonRaces', () {
    final dummyRace = Dummies.createRace();
    final List<Race> races = [dummyRace];

    test('returns races from remote and caches them', () async {
      when(
        mockRemoteDataSource.getSeasonRaces(Dummies.dummySeason),
      ).thenAnswer((_) async => races);
      when(
        mockCacheDataSource.cacheSeasonRaces(Dummies.dummySeason, races),
      ).thenAnswer((_) async => {});
      when(
        mockCacheDataSource.getSeasonRaces(Dummies.dummySeason),
      ).thenAnswer((_) async => races);

      final result = await repository.getSeasonRaces(Dummies.dummySeason);

      expect(result, equals(races));
      verifyInOrder([
        mockRemoteDataSource.getSeasonRaces(Dummies.dummySeason),
        mockCacheDataSource.cacheSeasonRaces(Dummies.dummySeason, races),
        mockCacheDataSource.getSeasonRaces(Dummies.dummySeason),
      ]);
    });

    test(
      'returns cached races when remote fails and cache is not empty',
      () async {
        when(
          mockRemoteDataSource.getSeasonRaces(Dummies.dummySeason),
        ).thenThrow(Exception('API error'));
        when(
          mockCacheDataSource.getSeasonRaces(Dummies.dummySeason),
        ).thenAnswer((_) async => races);

        final result = await repository.getSeasonRaces(Dummies.dummySeason);

        expect(result, equals(races));
        verify(
          mockRemoteDataSource.getSeasonRaces(Dummies.dummySeason),
        ).called(1);
        verify(
          mockCacheDataSource.getSeasonRaces(Dummies.dummySeason),
        ).called(1);
        verifyNever(mockCacheDataSource.cacheSeasonRaces(any, any));
      },
    );

    test('throws error when remote fails and cache is empty', () async {
      when(
        mockRemoteDataSource.getSeasonRaces(Dummies.dummySeason),
      ).thenThrow(Exception('API error'));
      when(
        mockCacheDataSource.getSeasonRaces(Dummies.dummySeason),
      ).thenAnswer((_) async => <Race>[]);

      expect(
        () => repository.getSeasonRaces(Dummies.dummySeason),
        throwsA(isA<Exception>()),
      );

      verify(
        mockRemoteDataSource.getSeasonRaces(Dummies.dummySeason),
      ).called(1);
      verify(mockCacheDataSource.getSeasonRaces(Dummies.dummySeason)).called(1);
      verifyNever(mockCacheDataSource.cacheSeasonRaces(any, any));
    });
  });
}
