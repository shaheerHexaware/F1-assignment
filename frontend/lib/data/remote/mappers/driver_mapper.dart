import 'package:f1_api_client/api.dart';
import '../../../domain/models/driver/driver.dart';
import '../../../helpers/null_safety_helper.dart';
import 'mapper.dart';

class DriverMapper extends Mapper<DriverDTO, Driver> {
  @override
  Driver map(DriverDTO param) {
    return Driver(
      driverId:
          param.driverId.getNotNullParameter('Driver ID is missing') as String,
      code: param.code,
      givenName:
          param.givenName.getNotNullParameter('Given name is missing')
              as String,
      familyName:
          param.familyName.getNotNullParameter('Family name is missing')
              as String,
      dateOfBirth:
          param.dateOfBirth.getNotNullParameter('Date of birth is missing')
              as String,
      nationality:
          param.nationality.getNotNullParameter('Nationality is missing')
              as String,
    );
  }
}
