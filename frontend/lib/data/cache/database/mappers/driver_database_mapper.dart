import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class DriverDatabaseMapper extends Mapper<Driver, Map<String, dynamic>, void> {
  @override
  Map<String, dynamic> map(Driver param, {void metadata}) {
    return {
      DatabaseHelper.columnDriverId: param.driverId,
      DatabaseHelper.columnDriverCode: param.code,
      DatabaseHelper.columnDriverGivenName: param.givenName,
      DatabaseHelper.columnDriverFamilyName: param.familyName,
      DatabaseHelper.columnDriverDateOfBirth: param.dateOfBirth,
      DatabaseHelper.columnDriverNationality: param.nationality,
    };
  }
}
