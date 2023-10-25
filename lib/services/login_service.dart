import 'package:firebase_auth/firebase_auth.dart';
import 'package:jsonwebtoken_decode/jsonwebtoken_decode.dart' as jwt;
import 'package:list_contatos_foto_dio/exceptions/exceptions.dart';

class LoginService {
  final firebase = FirebaseAuth.instance;
  Future<bool> signUp(emailAddress, password) async {
    try {
      UserCredential credential = await firebase.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return credential.user!.emailVerified;
    } on FirebaseAuthException catch (_) {
      throw AppExceptionInvalideCredencial();
    } catch (_) {
      throw AppExceptionServerError();
    }
  }

  signOut() async {
    await firebase.signOut();
  }

  Future<bool> tokenExp() async {
    try {
      final String token = await firebase.currentUser?.getIdToken() as String;
      final result = jwt.JwtBuilder.fromToken(token);
      final temp = result.payload.claim('exp');

      DateTime tokenExpiration =
          DateTime.fromMillisecondsSinceEpoch(temp * 1000);

      return tokenExpiration.isBefore(DateTime.now());
    } catch (e) {
      return false;
    }
  }
}
