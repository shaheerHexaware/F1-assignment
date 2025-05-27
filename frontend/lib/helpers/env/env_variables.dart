import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:synchronized/synchronized.dart';
import '../null_safety_helper.dart';

import 'enum_environment.dart';

class EnvironmentVariables {
  EnvironmentVariables._internal();

  static final EnvironmentVariables _instance =
      EnvironmentVariables._internal();

  static EnvironmentVariables get instance => _instance;

  bool _variablesLoaded = false;
  final _lock = Lock();

  String get _envFileName {
    return kDebugMode ? '.envdev' : '.env';
  }

  Future<void> _loadEnv() async {
    if (!_variablesLoaded) {
      await _lock.synchronized(() async {
        if (!_variablesLoaded) {
          await dotenv.load(fileName: _envFileName);
          _variablesLoaded = true;
        }
      });
    }
  }

  Future<String> getValue({required EnvironmentKeys path}) async {
    await _loadEnv();
    return dotenv.env[path.name].getNotNullParameter(
          '${path.name} Environment variable not found',
        )
        as String;
  }
}
