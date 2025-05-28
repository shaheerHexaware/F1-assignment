import 'package:f1_api_client/api.dart';
import '../../../domain/models/constructor/constructor.dart';
import '../../../helpers/mapper/mapper.dart';

class ConstructorMapper extends Mapper<ConstructorDTO, Constructor, void> {
  @override
  Constructor map(ConstructorDTO param, {void metadata}) {
    return Constructor(
      constructorId: param.constructorId,
      name: param.name,
      nationality: param.nationality,
    );
  }
}
