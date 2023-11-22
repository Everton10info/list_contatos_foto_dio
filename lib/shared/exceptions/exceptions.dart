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

class AppExceptionUserCreate extends  AppException{
  AppExceptionUserCreate(this.exception):super(exception);
 final String exception;

  
  @override
  String getMessage() {
    if(exception =='email-already-in-use') return 'Email já utilizado';
  
    return 'Erro desconhecido, tente novamente mais tarde!';
  }
}



class AppExceptionServerError extends AppException {
  AppExceptionServerError();
  @override
  String getMessage() {
    return 'Erro no servidor, por favor tente mais tarde';
  }
}

class AppExceptionConnect extends AppException {
  AppExceptionConnect([super.message]);
  @override
  String getMessage() {
    return 'Você está desconectado da internet';
  }
}
