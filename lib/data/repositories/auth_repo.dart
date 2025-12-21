import 'package:bill_share/data/services/firebase_auth_service.dart';
import 'package:bill_share/data/services/result.dart';
import 'package:bill_share/domain/models/auth_login_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoFirebase extends AuthRepo {
  final FirebaseAuthService _service;
  AuthRepoFirebase() : _service = FirebaseAuthService();

  @override
  Future<SuccessResult<UserCredential>> login(AuthLoginDto payload) async {
    try {
      final credential = await _service.firebaseAuth.signInWithEmailAndPassword(
        email: payload.email,
        password: payload.password,
      );
      print(credential);
      return SuccessResult(data: credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ErrorResult(
          message: e.message ?? "No user found for that email.",
          code: e.code,
        );
      } else if (e.code == 'wrong-password') {
        throw ErrorResult(
          message: e.message ?? "Wrong password provided for that user.",
          code: e.code,
        );
      }
      throw ErrorResult(
        message: e.message ?? "Something went wrong",
        code: e.code,
      );
    } catch (e) {
      throw ErrorResult(message: e.toString(), code: "500");
    }
  }
}

abstract class AuthRepo {
  Future<SuccessResult<UserCredential>> login(AuthLoginDto payload);
}
