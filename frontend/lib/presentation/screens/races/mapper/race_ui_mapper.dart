import 'package:f1_app/helpers/mapper/mapper.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/presentation/screens/races/models/race_ui.dart';

class RaceUiMapper extends Mapper<Race, RaceUi, bool> {
  @override
  RaceUi map(Race param, {bool? metadata}) {
    return RaceUi(
      year: param.year,
      round: param.round,
      name: param.name,
      date: param.date,
      driverName: param.winner.fullName,
      isWinnerChampion: metadata ?? false,
      circuitName: "${param.circuit.circuitName}, ${param.circuit.country}",
      constructorName: param.constructor.name,
    );
  }
}
