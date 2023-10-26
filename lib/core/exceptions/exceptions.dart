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
    return 'Email ou senha inválidos!';
  }
}

class AppExceptionCreateError extends AppException {
  AppExceptionCreateError();
  @override
  String getMessage() {
    return 'Erro ao criar usuário, por favor tente mais tarde';
  }
}

class AppExceptionServerError extends AppException {
  AppExceptionServerError();
  @override
  String getMessage() {
    return 'Erro no servidor, por favor tente mais tarde';
  }
}
