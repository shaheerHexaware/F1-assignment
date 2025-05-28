import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class DriverDomainMapper extends Mapper<Map<String, dynamic>, Driver, void> {
  @override
  Driver map(Map<String, dynamic> param, {void metadata}) {
    return Driver(
      driverId: param[DatabaseHelper.columnDriverId],
      code: param[DatabaseHelper.columnDriverCode],
      givenName: param[DatabaseHelper.columnDriverGivenName],
      familyName: param[DatabaseHelper.columnDriverFamilyName],
      dateOfBirth: param[DatabaseHelper.columnDriverDateOfBirth],
      nationality: param[DatabaseHelper.columnDriverNationality],
    );
  }
}
