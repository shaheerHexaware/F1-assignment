enum EnvironmentKeys { baseUrl, seasionStartYear }

/// Make sure the enum name should be same as key defined in the .env file.
extension EnvironmentKeysExtension on EnvironmentKeys {
  String get name {
    switch (this) {
      case EnvironmentKeys.baseUrl:
        return 'BASE_URL';
      case EnvironmentKeys.seasionStartYear:
        return 'SEASON_START_YEAR';
    }
  }
}
