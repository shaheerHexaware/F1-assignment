import 'package:f1_api_client/api.dart';
import '../../../domain/models/race/race.dart';
import '../../../helpers/mapper/mapper.dart';
import 'driver_mapper.dart';
import 'circuit_mapper.dart';
import 'constructor_mapper.dart';

class RaceMapper extends Mapper<RaceDTO, Race, void> {
  final DriverMapper _driverMapper;
  final CircuitMapper _circuitMapper;
  final ConstructorMapper _constructorMapper;

  RaceMapper(this._driverMapper, this._circuitMapper, this._constructorMapper);

  @override
  Race map(RaceDTO param, {void metadata}) {
    final winningDriver = param.winningDriver;
    final circuit = param.circuit;
    final constructor = param.winningConstructor;

    return Race(
      year: param.seasonYear,
      round: param.round,
      name: param.raceName,
      date: param.date,
      winner: _driverMapper.map(winningDriver),
      circuit: _circuitMapper.map(circuit),
      constructor: _constructorMapper.map(constructor),
    );
  }
}
