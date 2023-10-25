import '../core/enums/login_enum.dart';
import '../services/login_service.dart';

abstract interface class LoginRepository {
  Future<LoginState> login(String email, String password);
}

class LoginrepositoryImpl implements LoginRepository {
  final LoginService service;

  LoginrepositoryImpl({required this.service});
  @override
  Future<LoginState> login(String email, String password) async {
    @override
    final loged = await service.signUp(email, password);
    if (loged) {
      return LoginState.loggedIn;
    }
    return LoginState.loggedOut;
  }
}
