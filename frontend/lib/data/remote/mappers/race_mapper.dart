import 'package:f1_api_client/api.dart';
import '../../../domain/models/race/race.dart';
import 'mapper.dart';
import '../../../helpers/null_safety_helper.dart';
import 'driver_mapper.dart';
import 'circuit_mapper.dart';
import 'constructor_mapper.dart';

class RaceMapper extends Mapper<RaceDTO, Race> {
  final DriverMapper _driverMapper;
  final CircuitMapper _circuitMapper;
  final ConstructorMapper _constructorMapper;

  RaceMapper(this._driverMapper, this._circuitMapper, this._constructorMapper);

  @override
  Race map(RaceDTO param) {
    print(param.date);
    final winningDriver =
        param.winningDriver.getNotNullParameter('Winning driver is missing')
            as DriverDTO;
    final circuit =
        param.circuit.getNotNullParameter('Circuit is missing') as CircuitDTO;
    final constructor =
        param.winningConstructor.getNotNullParameter('Constructor is missing')
            as ConstructorDTO;

    return Race(
      year: param.seasonYear,
      round: param.round,
      name:
          param.raceName.getNotNullParameter('Race name is missing') as String,
      date: param.date,
      winner: _driverMapper.map(winningDriver),
      circuit: _circuitMapper.map(circuit),
      constructor: _constructorMapper.map(constructor),
    );
  }
}
