import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/dto/user.dto.dart';
import 'package:bill_share/interface/user.interface.dart';
import 'package:bill_share/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo implements IUser {
  final db = FirebaseFirestore.instance;
  @override
  Future<UserModel?> createUser({required CreateUserDTO payload}) async {
    final data = payload.toJson();
    await db.collection(COLLECTIONS.user.name).doc().set(data);
    return payload.user;
  }

  @override
  Future<UserModel?> signIn({String? email, String? password}) async {
    final usersRef = db.collection(COLLECTIONS.user.name);
    final query = usersRef.where('email', isEqualTo: email);
    final result = await query.get();

    // print(result.docs);
    // final data = UserModel.fromJson(result.docs);
    // return data;
  }
}
