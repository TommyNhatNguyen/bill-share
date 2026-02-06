import 'package:bill_share/core/models/result.dart';
import 'package:bill_share/data/interfaces/user_interface.dart';
import 'package:bill_share/data/services/firebase_firestore_service.dart';
import 'package:bill_share/domain/models/user_create_dto.dart';
import 'package:bill_share/domain/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepoFirebase implements IUser {
  final FirebaseFirestore db = FirebaseFirestoreService().db;
  @override
  Future<SuccessResult<UserModel?>> createUser(UserCreateDto payload) async {
    try {
      final json = payload.toJson();
      final response = await db.collection("users").add(json);
      final _response = await response.get();
      return SuccessResult(data: UserModel.fromJson(_response.data() ?? {}));
    } catch (e) {
      throw ErrorResult(message: e.toString(), code: "500");
    }
  }
}
