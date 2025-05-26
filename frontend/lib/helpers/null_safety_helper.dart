extension NullSafetyHelper on Object? {
  Object getNotNullParameter(String? errorMessage) {
    if (this != null) {
      return this!;
    } else {
      throw ArgumentError(errorMessage ?? "Not null argument is null.");
    }
  }
}
