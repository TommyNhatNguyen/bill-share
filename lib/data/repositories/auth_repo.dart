import 'package:bill_share/data/services/firebase_auth_service.dart';
import 'package:bill_share/data/services/result.dart';
import 'package:bill_share/domain/models/auth_login_dto.dart';
import 'package:bill_share/domain/models/auth_register_dto.dart';
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

  @override
  Future<SuccessResult<bool>> logout() async {
    try {
      await _service.firebaseAuth.signOut();
      return SuccessResult(data: true);
    } catch (e) {
      throw ErrorResult(message: e.toString(), code: "500");
    }
  }

  @override
  Future<SuccessResult<UserCredential>> register(
    AuthRegisterDto payload,
  ) async {
    try {
      final credential = await _service.firebaseAuth
          .createUserWithEmailAndPassword(
            email: payload.email,
            password: payload.password,
          );
      return SuccessResult(data: credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ErrorResult(
          message: e.message ?? "The password provided is too weak.",
          code: e.code,
        );
      } else if (e.code == 'email-already-in-use') {
        throw ErrorResult(
          message: e.message ?? "The account already exists for that email.",
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
  Future<SuccessResult<bool>> logout();
  Future<SuccessResult<UserCredential>> register(AuthRegisterDto payload);
}
