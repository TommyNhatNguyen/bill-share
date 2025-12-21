import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? username;
  String? phone;
  String? email;
  User? user;

  UserModel({this.username, this.phone, this.email, this.user});
  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'phone': phone,
    'email': email,
    'user': user,
  };
}
