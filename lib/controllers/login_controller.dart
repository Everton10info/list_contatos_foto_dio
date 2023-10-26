import '../core/enums/login_enum.dart';
import '../core/exceptions/exceptions.dart';
import '../repositories/auth_repository.dart';

class LoginController {
  final AuthRepository loginRepository;

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

  Future<String?> createUser(String email, String password) async {
    try {
      final result = await loginRepository.register(email, password);

      if (result == 'ok') return result;
      return '';
    } on AppException catch (e) {
      return e.getMessage();
    }
  }
}
