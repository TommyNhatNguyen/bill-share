import 'package:bill_share/core/models/result.dart';
import 'package:bill_share/domain/models/user_create_dto.dart';
import 'package:bill_share/domain/models/user_model.dart';

abstract interface class IUser {
  Future<SuccessResult<UserModel?>> createUser(UserCreateDto payload);
}
