import 'package:bill_share/dto/auth.dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuth {
  Future<UserCredential> signIn(AuthSignInDTO payload);
  Future<UserCredential> signUp(AuthSignUpDTO payload);
}
