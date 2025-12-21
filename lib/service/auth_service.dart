import 'package:bill_share/constants/storage.dart';
import 'package:bill_share/dto/auth.dto.dart';
import 'package:bill_share/repositories/auth_repo.dart';
import 'package:bill_share/service/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _authRepo = AuthRepo();
  final storageService = StorageService();

  Future<UserCredential> signIn(AuthSignInDTO payload) async {
    try {
      final data = await _authRepo.signIn(payload);
      // Get the ID token from the user
      if (data.user != null) {
        final token = await data.user!.getIdToken();
        await storageService.write(StorageKey.token, token!);
      }

      return data;
    } on FirebaseAuthException catch (error) {
      throw error;
    }
  }

  Future<UserCredential> signUp(AuthSignUpDTO payload) async {
    try {
      final data = await _authRepo.signUp(payload);
      // Get the ID token from the user
      if (data.user != null) {
        final token = await data.user!.getIdToken();
        await storageService.write(StorageKey.token, token!);
      }
      return data;
    } on FirebaseAuthException catch (error) {
      throw error;
    }
  }
}
