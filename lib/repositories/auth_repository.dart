import '../core/enums/login_enum.dart';
import '../services/auth_service.dart';

abstract interface class AuthRepository {
  Future<LoginState> login(String email, String password);
  Future<String> register(String email, String password);
  Future<void> logOut();
  Future<bool> verifyToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl({required this.service});
  @override
  Future<LoginState> login(String email, String password) async {
    @override
    final loged = await service.signUp(email, password);
    if (loged) {
      return LoginState.loggedIn;
    }
    return LoginState.loggedOut;
  }

  @override
  Future<String> register(String email, String password) async {
    @override
    final res = await service.createUser(email, password);
    if (res.uid.isNotEmpty) {
      return 'ok';
    }
    return res.toString();
  }

  @override
  Future<void> logOut() async {
    service.signOut();
    UserState(stateUser: LoginState.loggedOut);
  }

  @override
  Future<bool> verifyToken() async {
    final tokenIsOK = await service.verifyUserToken();
    return tokenIsOK;
  }
}
