import 'package:list_contatos_foto_dio/core/enums/login_enum.dart';
import 'package:list_contatos_foto_dio/exceptions/exceptions.dart';
import 'package:list_contatos_foto_dio/repositories/login_repository.dart';

class LoginController {
  final LoginRepository loginRepository;

  LoginController({
    required this.loginRepository,
  });
  Future<String?> signUp(String email, String password) async {
    try {
      final result = await loginRepository.login(email, password);

      if (result == LoginState.loggedIn) return LoginState.loggedIn.name;
      return LoginState.loggedOut.name;
    } on AppException catch (e) {
      return e.getMessage();
    }
  }
}
