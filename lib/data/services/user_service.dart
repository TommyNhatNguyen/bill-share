import 'package:bill_share/core/models/result.dart';
import 'package:bill_share/data/interfaces/user_interface.dart';
import 'package:bill_share/data/repositories/user_repo.dart';
import 'package:bill_share/domain/models/user_create_dto.dart';
import 'package:bill_share/domain/models/user_model.dart';

class UserService implements IUser {
  final UserRepoFirebase _repo;
  UserService() : _repo = UserRepoFirebase();

  @override
  Future<SuccessResult<UserModel?>> createUser(UserCreateDto payload) async {
    try {
      final data = await _repo.createUser(payload);
      return data;
    } catch (e) {
      throw ErrorResult(message: e.toString());
    }
  }
}
