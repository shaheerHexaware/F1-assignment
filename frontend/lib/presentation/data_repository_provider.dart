import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../data/data_repository.dart';
import '../data/remote/remote_data_source.dart';
import '../helpers/env/enum_environment.dart';
import '../helpers/env/env_variables.dart';

class DataRepositoryProvider extends StatelessWidget {
  const DataRepositoryProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureProvider<DataRepository>(
      create: (context) async => DataRepository(
        remoteDataSource: RemoteDataSource(
          baseUrl: await EnvironmentVariables.instance.getValue(
            path: EnvironmentKeys.baseUrl,
          ),
        ),
      ),
      initialData: DataRepository(),
      child: child,
    );
  }
}
