import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/presentation/screens/races/mapper/race_ui_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../dummies.dart';

void main() {
  late RaceUiMapper mapper;
  late Race testRace;

  setUp(() {
    mapper = RaceUiMapper();
    testRace = Dummies.createRace();
  });

  test('maps Race to RaceUi without metadata parameter', () {
    final result = mapper.map(testRace);

    final expectedRaceUi = Dummies.createRaceUi(isWinnerChampion: false);

    expect(result.year, equals(expectedRaceUi.year));
    expect(result.round, equals(expectedRaceUi.round));
    expect(result.name, equals(expectedRaceUi.name));
    expect(result.date, equals(expectedRaceUi.date));
    expect(result.driverName, equals(expectedRaceUi.driverName));
    expect(result.isWinnerChampion, equals(expectedRaceUi.isWinnerChampion));
    expect(result.circuitName, equals(expectedRaceUi.circuitName));
    expect(result.constructorName, equals(expectedRaceUi.constructorName));
  });

  test('maps Race to RaceUi with metadata parameter true', () {
    final result = mapper.map(testRace, metadata: true);

    final expectedRaceUi = Dummies.createRaceUi(isWinnerChampion: true);

    expect(result.year, equals(expectedRaceUi.year));
    expect(result.round, equals(expectedRaceUi.round));
    expect(result.name, equals(expectedRaceUi.name));
    expect(result.date, equals(expectedRaceUi.date));
    expect(result.driverName, equals(expectedRaceUi.driverName));
    expect(result.isWinnerChampion, equals(expectedRaceUi.isWinnerChampion));
    expect(result.circuitName, equals(expectedRaceUi.circuitName));
    expect(result.constructorName, equals(expectedRaceUi.constructorName));
  });

  test('maps Race to RaceUi with metadata parameter false', () {
    final result = mapper.map(testRace, metadata: false);

    final expectedRaceUi = Dummies.createRaceUi(isWinnerChampion: false);

    expect(result.year, equals(expectedRaceUi.year));
    expect(result.round, equals(expectedRaceUi.round));
    expect(result.name, equals(expectedRaceUi.name));
    expect(result.date, equals(expectedRaceUi.date));
    expect(result.driverName, equals(expectedRaceUi.driverName));
    expect(result.isWinnerChampion, equals(expectedRaceUi.isWinnerChampion));
    expect(result.circuitName, equals(expectedRaceUi.circuitName));
    expect(result.constructorName, equals(expectedRaceUi.constructorName));
  });
}
