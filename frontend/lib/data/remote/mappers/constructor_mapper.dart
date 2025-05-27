import 'package:f1_api_client/api.dart';
import '../../../domain/models/constructor/constructor.dart';
import '../../../helpers/null_safety_helper.dart';
import '../../../helpers/mapper/mapper.dart';

class ConstructorMapper extends Mapper<ConstructorDTO, Constructor, void> {
  @override
  Constructor map(ConstructorDTO param, {void metadata}) {
    return Constructor(
      constructorId:
          param.constructorId.getNotNullParameter('Constructor ID is missing')
              as String,
      name:
          param.name.getNotNullParameter('Constructor name is missing')
              as String,
      nationality:
          param.nationality.getNotNullParameter(
                'Constructor nationality is missing',
              )
              as String,
    );
  }
}
