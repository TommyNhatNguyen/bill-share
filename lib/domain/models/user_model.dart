import 'package:bill_share/constants/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? username;
  String? phone;
  PhoneCode? phoneCode;
  String? email;
  User? user;

  UserModel({this.username, this.phone, this.email, this.user, this.phoneCode});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      phone: json['phone'],
      phoneCode: json['phoneCode'] != null
          ? PhoneCode.fromString(json['phoneCode'])
          : null,
      email: json['email'],
      user: json['user'],
    );
  }
}
