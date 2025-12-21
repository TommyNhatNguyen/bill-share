import 'package:bill_share/dto/auth.dto.dart';
import 'package:bill_share/interface/auth.interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo implements IAuth {
  @override
  Future<UserCredential> signIn(AuthSignInDTO payload) async {
    final data = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: payload.email,
      password: payload.password,
    );

    return data;
  }

  @override
  Future<UserCredential> signUp(AuthSignUpDTO payload) async {
    final data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: payload.email,
      password: payload.password,
    );

    return data;
  }
}
