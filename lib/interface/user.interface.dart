import 'package:bill_share/dto/user.dto.dart';
import 'package:bill_share/models/user.dart';

abstract class IUser {
  Future<UserModel?> createUser({required CreateUserDTO payload});
  Future<UserModel?> signIn({String email, String password});
}
