class ApiErrors {
  const ApiErrors._(this.message);

  final String message;

  factory ApiErrors.invalidDelete() => const ApiErrors._(
      'This item can\'t be deleted as it is associated with other records in the database');

  factory ApiErrors.timeOut() => const ApiErrors._(
      'Connection timed out. Please try again later with a strong internet connection');

  factory ApiErrors.socket() =>
      const ApiErrors._('It seems you don\'t have internet connection');

  factory ApiErrors.unknown() =>
      const ApiErrors._('An unknown error happened. Please try again later');

  @override
  String toString(){
    return 'API ERROR: $message';
  }
}
