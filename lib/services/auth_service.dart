import 'package:firebase_auth/firebase_auth.dart';
import 'package:jsonwebtoken_decode/jsonwebtoken_decode.dart' as jwt;
import 'package:list_contatos_foto_dio/shared/exceptions/exceptions.dart';
import 'package:list_contatos_foto_dio/models/user.dart';

class AuthService {
  final firebase = FirebaseAuth.instance;
  Future<bool> signUp(emailAddress, password) async {
    try {
      UserCredential credential = await firebase.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      var name = credential.user!.email!.split('@');
      UserApp.userName = name[0];
      return credential.user!.uid.isNotEmpty;
    } on FirebaseAuthException catch (_) {
      throw AppExceptionInvalideCredencial();
    } catch (_) {
      throw AppExceptionServerError();
    }
  }

  Future<User> createUser(emailAddress, password) async {
    try {
      UserCredential credential = await firebase.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user!;
    } catch (_) {
      throw AppExceptionServerError();
    }
  }

  signOut() async {
    await firebase.signOut();
  }

  Future<bool> verifyUserToken() async {
    try {
      final String token = await firebase.currentUser?.getIdToken() as String;
      final result = jwt.JwtBuilder.fromToken(token);
      final temp = result.payload.claim('exp');

      var name = firebase.currentUser!.email!.split('@');
      UserApp.userName = name[0];

      DateTime tokenExpiration =
          DateTime.fromMillisecondsSinceEpoch(temp * 1000);

      var ok = tokenExpiration.isAfter(DateTime.now());
      return ok;
    } catch (e) {
      return false;
    }
  }
}
