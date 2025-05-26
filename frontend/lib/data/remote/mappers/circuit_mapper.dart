import 'package:f1_api_client/api.dart';
import '../../../domain/models/circuit/circuit.dart';
import '../../../helpers/null_safety_helper.dart';
import 'mapper.dart';

class CircuitMapper extends Mapper<CircuitDTO, Circuit> {
  @override
  Circuit map(CircuitDTO param) {
    return Circuit(
      circuitId:
          param.circuitId.getNotNullParameter('Circuit ID is missing')
              as String,
      circuitName:
          param.circuitName.getNotNullParameter('Circuit name is missing')
              as String,
      location: CircuitLocation(
        locality:
            param.location.locality.getNotNullParameter(
                  'Circuit locality is missing',
                )
                as String,
        country:
            param.location.country.getNotNullParameter(
                  'Circuit country is missing',
                )
                as String,
      ),
    );
  }
}
