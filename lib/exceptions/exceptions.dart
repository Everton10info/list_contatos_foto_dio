abstract class AppException implements Exception {
  final dynamic message;

  AppException([this.message]);

  String getMessage();

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}

class AppExceptionInvalideCredencial extends AppException {
  AppExceptionInvalideCredencial([super.message]);
  @override
  String getMessage() {
    return 'Credenciais inválidas!!';
  }
}

class AppExceptionServerError extends AppException {
  AppExceptionServerError();
  @override
  String getMessage() {
    return 'Erro no servidor, tente mais tarde';
  }
}
