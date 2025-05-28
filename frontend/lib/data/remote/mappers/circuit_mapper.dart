import 'package:f1_api_client/api.dart';
import '../../../domain/models/circuit/circuit.dart';
import '../../../helpers/mapper/mapper.dart';

class CircuitMapper extends Mapper<CircuitDTO, Circuit, void> {
  @override
  Circuit map(CircuitDTO param, {void metadata}) {
    return Circuit(
      circuitId: param.circuitId,
      circuitName: param.circuitName,
      locality: param.location.locality,
      country: param.location.country,
    );
  }
}
