import 'package:f1_api_client/api.dart';
import '../../../domain/models/driver/driver.dart';
import '../../../helpers/mapper/mapper.dart';

class DriverMapper extends Mapper<DriverDTO, Driver, void> {
  @override
  Driver map(DriverDTO param, {void metadata}) {
    return Driver(
      driverId: param.driverId,
      code: param.code,
      givenName: param.givenName,
      familyName: param.familyName,
      dateOfBirth: param.dateOfBirth,
      nationality: param.nationality,
    );
  }
}
