enum LoginState { loggedIn, loggedOut }

class UserState {
  final LoginState stateUser;

  UserState({required this.stateUser});
}
