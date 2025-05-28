import 'package:f1_app/data/data_repository.dart';
import 'package:f1_app/data/data_repository_impl.dart';
import 'package:f1_app/data/remote/open_api_remote_data_source.dart';
import 'package:f1_app/helpers/env/enum_environment.dart';
import 'package:f1_app/helpers/env/env_variables.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DataRepositoryProvider extends StatelessWidget {
  const DataRepositoryProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureProvider<DataRepository>(
      create: (context) async => DataRepositoryImpl(
        remoteDataSource: OpenApiRemoteDataSource(
          baseUrl: await EnvironmentVariables.instance.getValue(
            path: EnvironmentKeys.baseUrl,
          ),
        ),
      ),
      initialData: DataRepositoryImpl(),
      child: child,
    );
  }
}
