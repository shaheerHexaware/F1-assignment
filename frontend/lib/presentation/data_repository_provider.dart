import 'package:f1_app/data/data_repository.dart';
import 'package:f1_app/data/data_repository_impl.dart';
import 'package:f1_app/data/remote/open_api_remote_data_source.dart';
import 'package:f1_app/helpers/env/env.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DataRepositoryProvider extends StatelessWidget {
  const DataRepositoryProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (context) => DataRepositoryImpl(
        remoteDataSource: OpenApiRemoteDataSource(baseUrl: apiUrl),
      ),
      child: child,
    );
  }
}
