import 'package:bill_share/dto/auth.dto.dart';
import 'package:bill_share/models/user.dart';

class CreateUserDTO {
  late UserModel user;
  late AuthSignUpDTO auth;

  CreateUserDTO({required this.user, required this.auth});
  CreateUserDTO.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    auth = json['auth'];
  }
  Map<String, dynamic> toJson() => {'user': user, 'auth': auth};
}
