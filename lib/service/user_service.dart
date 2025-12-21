import 'package:bill_share/dto/user.dto.dart';
import 'package:bill_share/models/user.dart';
import 'package:bill_share/repositories/user_repo.dart';
import 'package:bill_share/service/auth_service.dart';

class UserService {
  final _authService = AuthService();
  final _userRepo = UserRepo();

  Future<UserModel?> createUser({required CreateUserDTO payload}) async {
    try {
      await _authService.signUp(payload.auth);
      final data = await _userRepo.createUser(payload: payload);
      return data;
    } catch (error) {
      throw error;
    }
  }

  // Future<User?> signIn({String? email, String? password}) async {
  //   try {
  //     await _authService.signIn(email: email, password: password);
  //     final data = await _userRepo.signIn(email: email, password: password);
  //     print(data);
  //     return data;
  //   } catch (error) {
  //     throw error;
  //   }
  // }
}
