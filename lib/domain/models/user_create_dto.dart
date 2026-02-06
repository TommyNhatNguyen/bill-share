import 'package:equatable/equatable.dart';

class UserCreateDto extends Equatable {
  final String username;
  final String userId;
  final String? phone;
  final String? email;
  final String? phoneCode;

  const UserCreateDto({
    required this.username,
    required this.userId,
    this.phone,
    this.email,
    this.phoneCode,
  });

  factory UserCreateDto.fromJson(Map<String, dynamic> json) {
    return UserCreateDto(
      username: json['username'],
      userId: json['userId'],
      phone: json['phone'],
      phoneCode: json['phoneCode'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'userId': userId,
      'phone': phone,
      'email': email,
      'phoneCode': phoneCode,
    };
  }

  UserCreateDto copyWith({
    String? username,
    String? userId,
    String? phone,
    String? email,
    String? phoneCode,
  }) {
    return UserCreateDto(
      username: username ?? this.username,
      userId: userId ?? this.userId,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      phoneCode: phoneCode ?? this.phoneCode,
    );
  }

  @override
  List<Object?> get props => [username, userId, phone, email, phoneCode];
}
